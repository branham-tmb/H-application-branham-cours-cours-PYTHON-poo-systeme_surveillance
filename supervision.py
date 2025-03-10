import os
import socket
import datetime
import mysql.connector
from twilio.rest import Client

# Configuration Twilio
ACCOUNT_SID = "xxxx"
AUTH_TOKEN = "xxxx"
TWILIO_NUMBER = "+12318331675"  # Numéro Twilio (SMS)
ADMIN_NUMBER = "+"  # Numéro Admin (SMS)

#TWILIO_NUMBER="whatsapp:+14155238886",  # Numéro Twilio pour WhatsApp
#ADMIN_NUMBER="whatsapp:+243xxx"  # Ton numéro WhatsApp avec l'indicatif (ex: +336XXXXXXXX)

client = Client(ACCOUNT_SID, AUTH_TOKEN)

# Connexion à MySQL
db = mysql.connector.connect(
    host="localhost",
    user="root",
    password="",
    database="supervision"
)
cursor = db.cursor()

# Liste des équipements surveillés avec leurs IP
devices = {
    "Routeur Principal": {"ip": "192.168.1.1", "services": []},
    "Serveur Web": {"ip": "192.168.1.10", "services": [80]},
    "Serveur SSH": {"ip": "192.168.1.20", "services": [22]}
}

# Vérification de connexion via Ping
def check_ping(host):
    response = os.system(f"ping -n 1 {host} > nul 2>&1")  # Windows (-n 1)
    return response == 0

# Vérification des services (ex: HTTP, SSH)
def check_service(host, port):
    try:
        with socket.create_connection((host, port), timeout=3):
            return True
    except (socket.timeout, ConnectionRefusedError):
        return False

# Vérification si l'équipement existe, sinon l'ajouter avec son IP
def ensure_device_exists(device_name, ip_address):
    cursor.execute("SELECT id FROM equipements WHERE nom = %s", (device_name,))
    result = cursor.fetchone()
    
    if result is None:  # Si l'équipement n'existe pas, l'ajouter
        cursor.execute("INSERT INTO equipements (nom, ip, etat) VALUES (%s, %s, 'OK')", (device_name, ip_address))
        db.commit()
        cursor.execute("SELECT id FROM equipements WHERE nom = %s", (device_name,))
        result = cursor.fetchone()

    return result[0]  # Retourner l'ID de l'équipement

# Enregistrement des événements dans MySQL
# Enregistrement des événements dans MySQL
def log_event(message, status="En panne"):
    timestamp = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    
    # Extraire le nom de l'équipement à partir du message
    device_name = message.split(":")[1].split("(")[0].strip()

    # Vérifier si l'équipement existe, sinon l'ajouter avec son IP
    device_ip = devices.get(device_name, {}).get("ip", None)
    if device_ip:
        # Vérifier que l'équipement existe avant de tenter d'ajouter un log
        device_id = ensure_device_exists(device_name, device_ip)
    else:
        print(f"[ERREUR] L'équipement {device_name} n'a pas d'IP définie dans le dictionnaire 'devices'.")
        device_id = None  # Si l'équipement n'existe pas, on met device_id à None

    # Si un ID valide a été récupéré, insérer l'événement dans la table logs
    if device_id:
        cursor.execute("INSERT INTO logs (timestamp, message, equipement_id) VALUES (%s, %s, %s)", (timestamp, message, device_id))
        db.commit()
        print(f"[LOG] {message}")

        # Mettre à jour l'état de l'équipement
        cursor.execute("UPDATE equipements SET etat=%s WHERE id=%s", (status, device_id))
        db.commit()
    else:
        print(f"[ERREUR] Impossible d'ajouter un log pour l'équipement {device_name} car aucun ID valide n'a été trouvé.")


# Envoi d'alerte par SMS
def send_alert(message):
    try:
        client.messages.create(from_=TWILIO_NUMBER, body=message, to=ADMIN_NUMBER)
        print("[ALERTE] Message SMS envoyé !")
    except Exception as e:
        print(f"[ERREUR] Impossible d'envoyer l'alerte SMS : {e}")

# Tentative de réparation automatique (exemple avec redémarrage de service)
def attempt_repair(name, ip, port=None):
    print(f"[RÉPARATION] Tentative de réparation pour {name}...")
    
    repaired = False
    
    # Exemple de réparation : Redémarrer un service spécifique
    if port == 80:  # Serveur Web
        os.system("net start W3SVC")  # Windows: Redémarrer IIS
        repaired = check_service(ip, 80)
    elif port == 22:  # Serveur SSH
        os.system("net start sshd")  # Windows: Redémarrer SSH
        repaired = check_service(ip, 22)
    elif not port:  # Ping KO => Redémarrage de la machine (exemple)
        os.system(f"shutdown /r /m \\\\{ip} /t 5")  # Windows: Redémarrer une machine distante
        repaired = check_ping(ip)
    
    # Mise à jour de l'état si réparation réussie
    if repaired:
        message = f"RÉPARÉ : {name} ({ip}) fonctionne à nouveau."
        log_event(message, status="OK")
        send_alert(message)
    else:
        message = f"ÉCHEC DE RÉPARATION : {name} ({ip}) toujours en panne."
        log_event(message)
        send_alert(message)

# Exécution de la surveillance
def main():
    for name, device in devices.items():
        ip = device["ip"]
        
        if not check_ping(ip):
            message = f"ALERTE : {name} ({ip}) est inactif !"
            log_event(message)
            send_alert(message)
            attempt_repair(name, ip)
        
        for port in device["services"]:
            if not check_service(ip, port):
                message = f"ALERTE : Service {port} de {name} ({ip}) est inactif !"
                log_event(message)
                send_alert(message)
                attempt_repair(name, ip, port)

if __name__ == "__main__":
    main()
