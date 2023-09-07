INSERT INTO `addon_account` (name, label, shared) VALUES 
	('society_autoecole','Auto Ecole',1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES 
	('society_autoecole', 'Auto Ecole', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES 
	('society_autoecole','Auto Ecole',1)
;

INSERT INTO `jobs` (`name`, `label`, `whitelisted`) VALUES
	('autoecole', 'Auto Ecole', 1)
;

INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
	('autoecole', 0, 'stagiaire', 'Stagiaire', 30, '', ''),
	('autoecole', 1, 'moniteur', 'Moniteur', 50, '', ''),
	('autoecole', 2, 'copatron', 'Co Patron', 80, '', ''),
	('autoecole', 3, 'boss', 'Patron', 100, '', '')