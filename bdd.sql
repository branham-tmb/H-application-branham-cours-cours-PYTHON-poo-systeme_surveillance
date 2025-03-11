CREATE DATABASE IF NOT EXISTS supervision;
USE supervision;

-- Table des équipements
CREATE TABLE IF NOT EXISTS equipements (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL UNIQUE,
    ip VARCHAR(15) NOT NULL,
    etat VARCHAR(20) DEFAULT 'Actif'
);

-- Table des logs
CREATE TABLE IF NOT EXISTS logs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    message TEXT NOT NULL,
    equipement_id INT,
    FOREIGN KEY (equipement_id) REFERENCES equipements(id) ON DELETE CASCADE
);

-- Insertion des équipements à surveiller
INSERT INTO equipements (nom, ip) VALUES
    ('Routeur Principal', '192.168.1.1'),
    ('Serveur Web', '192.168.1.10'),
    ('Serveur SSH', '192.168.1.20');
