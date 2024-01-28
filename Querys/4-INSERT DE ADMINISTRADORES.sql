--- INSERTANDO LOS ADMINISTRADORES

--	INSERTANDO ADMINISTRADORES
--	usuario: alejandro  contrase�a: admin1
--  usuario: edwing	    contrase�a: admin2
--  usuario: carlos     contrase�a: admin3

INSERT INTO Administrador (CedulaAdmimistrador, NombresAdministrador, ApellidosAdministrador, CorreoAdministrador, NumeroTelefonoAdministrador, Usuario, Contrasenia, IdSucursal)
VALUES ('121-160803-1001N', 'Edwing Antonio', 'Jarquin Fitoria', 'edwing@uni.com', '00001111', 'edwing', PWDENCRYPT('admin1'), 1),
	    ('366-000011-1000H', 'Alejandro Antonio', 'Castillo Jacamo', 'bluemonster@gmail.com', '11110000','alejandro',PWDENCRYPT('admin2'),2),
	    ('561-210703-1040L', 'Carlos Ernesto', 'Mora Rodriguez', 'cmora2023@gmail.com', '10101010','carlos',PWDENCRYPT('admin3'),7);

-- VER INFORMACION DE LOS ADMINISTRADORES INSERTADOS
/*
select * from Administrador where Usuario ='alejandro' and PWDCOMPARE('admin2', contrasenia)= 1
select * from Administrador where Usuario ='carlos' and PWDCOMPARE('admin1', contrasenia)= 1
select * from Administrador where Usuario ='edwing' and PWDCOMPARE('admin3', contrasenia)= 1  */
