-- -------------------------------------------------------------------JOSE SALAZAR 2019070------------------------------------------------------------------------------------------
Drop database if exists DBTonysKinal2019070;
Create Database DBTonysKinal2019070;

Use DBTonysKinal2019070;

-- -------------------------------------------------------EMPRESAS------------------------------------------------------------------------------------------------------------------
Create table Empresas (
	codigoEmpresa int auto_increment not null,
		nombreEmpresa varchar(150),
			direccion varchar(150),
		telefono varchar(10),
	Primary key PK_codigoEmpresa (codigoEmpresa)
);

Delimiter $$
Create procedure sp_AgregarEmpresa(
	in nombreEmpresa varchar(150), 
		in direccion varchar(150), 
			in telefono int)
				Begin
			insert into Empresas(nombreEmpresa, direccion, telefono)
		Values(nombreEmpresa, direccion, telefono);
	End$$
Delimiter ;

call sp_AgregarEmpresa('Pollo Campero Guatemala','8va.calle 19-17 zona 16','66312894');
call sp_AgregarEmpresa('Kentucky Fried Chicken','12va.calle 28-30 zona 5','24242424');
call sp_AgregarEmpresa('Tigo Guatemala','18va.calle 1-20 zona 2','66319030');
call sp_AgregarEmpresa('Saul Cafe Guatemala','23.calle 10-00 zona 4','23798997');
call sp_AgregarEmpresa('Wendy´s','10ma.calle 5-47 zona 10','24112611');

Delimiter $$
	Create procedure sp_ListarEmpresas()
		Begin
			Select
				Empresas.codigoEmpresa,
					Empresas.nombreEmpresa,
				Empresas.direccion,
			Empresas.telefono
		from Empresas;
	end $$
delimiter ;

call sp_ListarEmpresas();


/*ALTER USER 'root'@'localhost' identified WITH mysql_native_password BY '123456';*/


Delimiter $$
	Create procedure sp_ActualizarEmpresa(in codigoEmp int, in nomEmp varchar(150), in dirEmpresa varchar(150), in telEmpresa varchar(10))
		Begin
			update Empresas
				set 		
					nombreEmpresa=nomEmp,
				direccion=dirEmpresa,
			telefono=telEmpresa
		Where(codigoEmpresa=codigoEmp);
	End$$
Delimiter ;


delimiter $$ 
Create procedure sp_BuscarEmpresa(codEmp int)
begin
	select 
		Empresas.codigoEmpresa,
			Empresas.nombreEmpresa,
				Empresas.direccion,
			Empresas.telefono
		from Empresas
	where(codigoEmpresa=codEmp);
end $$
delimiter ;

call sp_BuscarEmpresa(5);

delimiter $$
	Create procedure sp_EliminarEmpresa(codigoEmp int)
		begin
			delete from Empresas
		where(codigoEmpresa=codigoEmp);
	end $$
delimiter ;


-- ----------------------------------------------------------Presupuesto-------------------------------------------------------------------------------------------------------------
Create table Presupuesto (
	codigoPresupuesto int auto_increment not null,
		fechaSolicitud date,
			cantidadPresupuesto decimal(10,2),
				codigoEmpresa int,
			Primary key PK_codigoPresupuesto (codigoPresupuesto),
		constraint FK_Presupuesto_Empresas
	Foreign key (codigoEmpresa) references Empresas(codigoEmpresa)
);


Delimiter $$
Create Procedure sp_AgregarPresupuesto(
	in fechaSolicitud date,
		in cantidadPresupuesto decimal(10,2),
			in codigoEmpresa int)
				Begin
			insert into Presupuesto(fechaSolicitud, cantidadPresupuesto, codigoEmpresa)
		values(fechaSolicitud, cantidadPresupuesto, codigoEmpresa);
	End $$
Delimiter ;

call sp_AgregarPresupuesto('2019-07-25','3647.21','1');
call sp_AgregarPresupuesto('2015-10-30','10574.20','2');
call sp_AgregarPresupuesto('2011-01-29','8751.73','3');
call sp_AgregarPresupuesto('2016-09-28','2347.81','4');
call sp_AgregarPresupuesto('2017-12-01','12280.30','5');


Delimiter $$
	Create Procedure sp_ListarPresupuestos()
		Begin
			select
				Presupuesto.codigoPresupuesto,
					Presupuesto.fechaSolicitud,
				Presupuesto.cantidadPresupuesto,
			Presupuesto.codigoEmpresa
		from Presupuesto;
	End$$
Delimiter ;

call sp_ListarPresupuestos();

Delimiter $$
	Create Procedure sp_ActualizarPresupuesto(in codigoPres int, in fechaSoli date, in cantiPresu decimal, in codEmp int)
		Begin
			update Presupuesto
				set
					fechaSolicitud=fechaSoli,
				cantidadPresupuesto=cantiPresu,
			codigoEmpresa=codEmp
		where(codigoPresupuesto=codigoPres);
    End$$
Delimiter ;


Delimiter $$
Create Procedure sp_BuscarPresupuesto(codPres int)
	Begin
		Select
			Presupuesto.codigoPresupuesto,
				Presupuesto.fechaSolicitud,
					Presupuesto.cantidadSolicitud,
				Presupuesto.codigoEmpresa
			from Presupuesto
		Where(codigoPresupuesto=codigoPres);
	End $$
Delimiter ;

delimiter $$
	Create procedure sp_EliminarPresupuesto(codigoPres int)
		begin
			delete from Presupuesto
		where(codigoPresupuesto=codigoPres);
	end $$
delimiter ;


-- ---------------------------------------------------------Servicios---------------------------------------------------------------------------------------
Create table Servicios (
	codigoServicio int auto_increment not null,
		fechaServicio date,
			tipoServicio varchar(100),
				horaServicio time,
					lugarServicio varchar(100),
				telefonoContacto varchar(10),
			codigoEmpresa int,
		Primary key PK_codigoServicio (codigoServicio),
	constraint FK_Servicios_Empresas
Foreign key (codigoEmpresa) references Empresas(codigoEmpresa)
);


Delimiter $$
	Create Procedure sp_AgregarServicio(
		in fechaServicio date,
			in tipoServicio varchar(100),
				in horaServicio time,
					in lugarServicio varchar(100),
						in telefonoContacto varchar(10),
					in codigoEmpresa int)
				Begin
			Insert into Servicios(fechaServicio, tipoServicio, horaServicio, lugarServicio, telefonoContacto, codigoEmpresa)
		values(fechaServicio, tipoServicio, horaServicio, lugarServicio, telefonoContacto, codigoEmpresa);
    End$$
Delimiter ;

call sp_AgregarServicio('2020-10-25','Gourmet','15:32:51','Ciudad Capital','45863210','1');
call sp_AgregarServicio('2020-09-30','Cena','18:25:30','San Lucas','65324180','2');
call sp_AgregarServicio('2020-11-08','Almuerzo','13:10:00','Tecpan','23301456','3');
call sp_AgregarServicio('2020-08-18','Lunch','16:20:15','Hotel Intercontinental','66312561','4');
call sp_AgregarServicio('2020-12-10','Desayuno','10:45:15','Tikal Peten','32654120','5');



Delimiter $$
Create Procedure sp_ListarServicios()
	Begin
		select
			Servicios.codigoServicio,
				Servicios.fechaServicio,
					Servicios.tipoServicio,
						Servicios.horaServicio,
					Servicios.lugarServicio,
				Servicios.telefonoContacto,
			Servicios.codigoEmpresa
		from Servicios;
	End $$
Delimiter ;

call sp_ListarServicios();

Delimiter $$
	Create Procedure sp_ActualizarServicio(in codServ int, in fechaServ date, in tipoServ varchar(100), in horaServ time, in lugarServ varchar(100), in telefonoCont varchar(10))
		Begin
			Update Servicios
				set
					fechaServicio=fechaServ,
						tipoServicio=tipoServ,
							horaServicio=horaServ,
						lugarServicio=lugarServ,
					telefonoContacto=telefonoCont
		where(codigoServicio=codServ);
	End$$
Delimiter ;


Delimiter $$
	Create procedure sp_BuscarServicio(codServ int)
		Begin
			Select 
				Servicios.codigoServicio,
					Servicios.fechaServicio,
						Servicios.tipoServicio,
							Servicios.horaServicio,
						Servicios.lugarServicio,
					Servicios.telefonoContacto,
				Servicios.codigoEmpresa
			from Servicios
		Where(codigoServicio=codServ);
	End$$
Delimiter ;

call sp_BuscarServicio(2);

Delimiter $$
	Create procedure sp_Eliminarervicio(codSer int)
		begin
			delete from Servicios
		Where(codigoServicio=codSer);
	End$$
Delimiter ;

-- ------------------------------------------------------------TipoPlato---------------------------------------------------------------------------------------------
Create table TipoPlato (
	codigoTipoPlato int auto_increment not null,
		descripcionTipo varchar(100),
	Primary key PK_cofdigoTipoPlato (codigoTipoPlato)
);


Delimiter $$
Create procedure sp_AgregarTipoPlato(
	in descripcionTipo varchar(100))
		Begin
			insert into TipoPlato(descripcionTipo)
		values(descripcionTipo);
	End$$
Delimiter ;

call sp_AgregarTipoPlato('El mas delicioso de los postres');
call sp_AgregarTipoPlato('El plato con el sabor mas exigente');
call sp_AgregarTipoPlato('Esta rica salsa hará que cualquier pieza de pollo quede con una textura cremosa y sabor suculento.');
call sp_AgregarTipoPlato('El cilantro le da un toque especial a uno de los pescados más ricos y saludables.');
call sp_AgregarTipoPlato('Y si ama lo picoso, siempre la puedes sorprender con esta salsa maravillosa');


Delimiter $$
	Create procedure sp_ListarTipoPlatos()
		Begin
			Select
				TipoPlato.codigoTipoPlato,
			TipoPlato.descripcionTipo
		from TipoPlato;
	End$$
Delimiter ;

call sp_ListarTipoPlatos();

Delimiter $$
	Create Procedure sp_ActualizarTipoPlato(in codTipPla int, in descripTip varchar(100))
		Begin
			update TipoPlato
				set
			descripcionTipo=descripTip
		where(codigoTipoPlato=codTipPla);
	End $$
Delimiter ;


Delimiter $$
Create Procedure sp_BuscarTipoPlato(codTipPla int)
	Begin
		select 
			TipoPlato.codigoTipoPlato,
				TipoPlato.descripcionTipo
			from TipoPlato
		Where(codigoTipoPlato=codTipPla);
	End$$
Delimiter ;


Delimiter $$
	Create Procedure sp_EliminarTipoPlato(codTipPla int)
		Begin
			delete from TipoPlato
		where(codigoTipoPlato=codTipPla);
	End$$
Delimiter ;

-- -------------------------------------------------------------Platos-----------------------------------------------------------------------------------------------
Create table Platos (
	codigoPlato int auto_increment not null,
		cantidad int,
			nombrePlato varchar(50),
				descripcionPlato varchar(150),
					precioPlato decimal(10,2),
				codigoTipoPlato int,
			Primary Key PK_codigoPlato (codigoPlato),
		constraint FK_Platos_TipoPlato
	Foreign key (codigoTipoPlato) references TipoPlato(codigoTipoPlato)
);

Delimiter $$
Create Procedure sp_AgregarPlato(
	in cantidad int,
		in nombrePlato varchar(50),
			in descripcionPlato varchar(150),
				in precioPlato decimal(10,2),
					in codigoTipoPlato int)
				Begin
			Insert into Platos(cantidad, nombrePlato, descripcionPlato, precioPlato, codigoTipoPlato)
		Values(cantidad, nombrePlato, descripcionPlato, precioPlato, codigoTipoPlato);
	End$$
Delimiter ;

call sp_AgregarPlato("4","Ensalada Cesar","Ensalada con verduras y mayonesa","45.21","1");
call sp_AgregarPlato("10","Papas fritas","Papas cortas fritas en aceite","15.34","2");
call sp_AgregarPlato("2","Pizzas medianas","Pizza con queso y extra tocino","30.54","3");
call sp_AgregarPlato("7","Sopas de la casa","Sopa de fideos y tomate","12.82","4");
call sp_AgregarPlato("3","Pasta Bolognesa","Fideos, carne molida y salsa especial","23.64","5");

Delimiter $$
	Create Procedure sp_ListarPlatos()
		Begin
			select 
				Platos.codigoPlato,
					Platos.cantidad,
						Platos.nombrePlato,
					Platos.descripcionPlato,
				Platos.precioPlato,
			Platos.codigoTipoPlato
		from Platos;
	End $$
Delimiter ;

call sp_ListarPlatos();

Delimiter $$
	Create Procedure sp_ActualizarPlato(in codPla int, in cant int, in nomPla varchar(50), in descPla varchar(150), in prePla decimal(10,2), in codTipPla int)
		Begin
			update Platos
				set
					cantidad=cant,
						nombrePlato=nomPla,
					descripcionPlato=descPla,
				precioPlato=prePla,
			codigoTipoPlato=codTipPla
		where(codigoPlato=codPla);
	End $$
Delimiter ;


Delimiter $$
Create Procedure sp_BuscarPlato(codPla int)
	Begin
		select 
			Platos.codigoPlato,
				Platos.cantidad,
					Platos.nombrePlato,
						Platos.descripcionPlato,
					Platos.precioPlato,
				Platos.codigoTipoPlato
			from Platos
		where(codigoPlato=codPla);
	End $$
Delimiter ;


Delimiter $$
	Create Procedure sp_ElimiarPlato(codPla int)
		Begin
			delete from Platos
		where(codigoPlato=codPla);
	End $$
Delimiter ;
-- -------------------------------------------------------Servicios_has_platos---------------------------------------------------------------------------------------
Create table Servicios_has_Platos(
codigoServicio int,
	codigoPlato int,
			constraint FK_Servicios_has_Platos_Servicios
		Foreign key (codigoServicio) references Servicios(codigoServicio),
	constraint FK_Servicios_has_Platos_Platos
Foreign key (codigoPlato) references Platos(codigoPlato)
);

Delimiter $$
	Create Procedure sp_AgregarServicios_has_Platos(
		in codigoServicio int,
			in codigoPlato int)
				Begin
			insert into Servicios_has_Platos(codigoServicio, codigoPlato)
		values(codigoServicio, codigoPlato);
	End$$
Delimiter ;


Delimiter $$
Create Procedure sp_ListarServicios_has_Platos()
	Begin
		Select codigoServicio, codigoPlato from
			(Select S.codigoServicio as codigoServicio from servicios S
				left join servicios_has_platos SP on SP.codigoServicio = S.codigoServicio) c1,
			(Select PL.codigoPlato as codigoPlato from platos PL
		left join servicios_has_platos SP on SP.codigoPlato =  PL.codigoPlato) c2;
	End $$
Delimiter ;

call sp_ListarServicios_has_Platos();

Delimiter $$
	Create Procedure sp_ActualizarServicios_has_Platos()
		Begin
			update Presupuesto
				set
			cosigoServicio=codigoServ,
		codigoPlato=codigoPla;
    End$$
Delimiter ;


Delimiter $$
Create Procedure sp_BuscarServicios_has_Platos()
	Begin
		Select
			Servicios_has_Platos.codigoServicio,
				Servicios_has_Platos.codigoPlatos
			from Servicios_has_Platos;
		End $$
Delimiter ;

delimiter $$
	Create procedure sp_EliminarServicios_has_Platos()
		begin
			delete from Servicios_has_Platos;
	end $$
delimiter ;

-- -----------------------------------------------------------Productos----------------------------------------------------------------------------------------------
Create table Productos(
codigoProducto int auto_increment not null,
	nombreProducto varchar(150),
		cantidad int,
	Primary key PK_codigoProducto (codigoProducto)
);


Delimiter $$
	Create Procedure sp_AgregarProductos(
		in nombreProducto varchar(150),
			in cantidad int)
				Begin
			Insert into Productos(nombreProducto, cantidad)
		values(nombreProducto, cantidad);
	End$$
Delimiter ;

call sp_AgregarProductos('Tomates manzanos','18');
call sp_AgregarProductos('Papas','25');
call sp_AgregarProductos('Queso Motzarela','21');
call sp_AgregarProductos('Fideos','35');
call sp_AgregarProductos('Tomates Rojos','20');

Delimiter $$
Create Procedure sp_ListarProductos()
	Begin
		Select 
			Productos.codigoProducto,
				Productos.nombreProducto,
			Productos.cantidad
		from Productos;
	End$$
Delimiter ;

call sp_ListarProductos();

Delimiter $$
Create Procedure sp_ActualizarProductos(in codPro int, in nomPro varchar(150), in cant int)
	Begin
		update Productos
			set
				nombreProducto=nomPro,
			cantidad=cant
		where(codigoProducto=codPro);
	End $$
Delimiter ;


Delimiter $$
	Create Procedure sp_BuscarProductos(codPro int)
		Begin
			select
				Productos.codigoProducto,
					Productos.nombreProducto,
				Productos.cantidad
			from Productos
		where(codigoProducto=codPro);
	End $$
Delimiter ;


Delimiter $$
	Create Procedure sp_EliminarProductos(codPro int)
		Begin
			delete from Productos
		where(codigoProducto=codPro);
	End$$
Delimiter ;
-- --------------------------------------------------------------Productos_has_Platos--------------------------------------------------------------------------------
Create table Productos_has_Platos(
codigoProducto int,
	codigoPlato int,
		constraint FK_Productos_has_Platos_Productos
			foreign key(codigoProducto) references Productos(codigoProducto),
		constraint FK_Productos_has_Platos_Platos
	foreign key(codigoPlato) references Platos(codigoPlato)
);


Delimiter $$
	Create Procedure sp_AgregarProductos_has_Platos(
		in codigoProducto int,
			in codigoPlato int)
				Begin
			Insert into Productos_has_Platos(codigoProducto, codigoPlato)
		values(codigoProducto, codigoPlato);
	End $$
Delimiter ;


Delimiter $$
Create Procedure sp_ListarProductos_has_Platos()
	Begin
		Select codigoProducto, codigoPlato from
			(Select P.codigoProducto as codigoProducto from Productos P
				left join Productos_has_Platos PH on PH.codigoProducto = P.codigoProducto) c1,
			(Select PL.codigoPlato as codigoPlato from Platos PL
		left join Productos_has_Platos PH on PH.codigoPlato = PL.codigoPlato) c3;
	End $$
Delimiter ;

call sp_ListarProductos_has_Platos();

Delimiter $$
	Create Procedure sp_ActualizarProductos_has_Platos()
		Begin
			update Productos_has_Platos
				set
			codigoProducto=codPro,
		codigoPlato=codPla;
	End $$
Delimiter ;


Delimiter $$
	Create Procedure sp_BuscarProductos_has_Platos(codPro int, codPla int)
		Begin
			Select
				Productos_has_Platos.codigoProducto,
			Productos_has_Platos.codigoPlato
		from Productos_has_Platos
        where (codigoProducto=codPro and codigoPlatos=codPla);
	End$$
Delimiter ;


Delimiter $$
	Create Procedure sp_EliminarProductos_has_Platos()
		Begin
			delete from Productos_has_Platos;
        End$$
Delimiter ;

-- ----------------------------------------------------------------TipoEmpleados-------------------------------------------------------------------------------------
Create table TipoEmpleados(
	codigoTipoEmpleado int auto_increment not null,
		descripcion varchar(100),
	Primary key (codigoTipoEmpleado)
);


Delimiter $$
Create Procedure sp_AgregarTipoEmpleado(
	in descripcion varchar(100))
		Begin
			Insert into TipoEmpleados(descripcion)
		values(descripcion);
	End $$
Delimiter ;

call sp_AgregarTipoEmpleado('Cocinero de la cocina numero 3');
call sp_AgregarTipoEmpleado('Camamero de las cenas esepeciales');
call sp_AgregarTipoEmpleado('Anfitrion de la entrada los dias domingo');
call sp_AgregarTipoEmpleado('Encargado de la cocina numero 1');
call sp_AgregarTipoEmpleado('Receptor de frutas y verduras del restaurante');

Delimiter $$
	Create Procedure sp_ListarTipoEmpleados()
		Begin
			select
				TipoEmpleados.codigoTipoEmpleado,
			TipoEmpleados.descripcion
		from TipoEmpleados;
	End $$
Delimiter ;

call sp_ListarTipoEmpleados();

Delimiter $$
	Create Procedure sp_ActualizarTipoEmpleado(in codTipEmp int, in descrip varchar(100))
		Begin
			update TipoEmpleados
				set 
					descripcion=descrip
		where(codigoTipoEmpleado=codTipEmp);
	End $$
Delimiter ;


Delimiter $$
Create Procedure sp_BuscarTipoEmpleado(codTipEmp int)
	Begin
		select
			TipoEmpleados.codigoTipoEmpleado,
				TipoEmpleados.descripcion
			from TipoEmpleados
		where(codigoTipoEmpleado=codTipEmp);
	End $$
Delimiter ;


Delimiter $$
	Create Procedure sp_ElimiarTipoEmpleado(codTipEmp int)
		Begin
			delete from TipoEmpleados
		where(codigoTipoEmpleado=codTipEmp);
	End $$
Delimiter ;
-- -----------------------------------------------------------------Empleados----------------------------------------------------------------------------------------
Create table Empleados(
	codigoEmpleado int auto_increment not null,
		numeroEmpleado int,
			apellidosEmpleado varchar(150),
				nombresEmpleado varchar(150),
					direccionEmpleado varchar(150),
						telefonoContacto varchar(10),
					gradoCocinero varchar(50),
				codigoTipoEmpleado int,
			Primary key (codigoEmpleado),
		constraint FK_Empleados_TipoEmpleados
	Foreign key (codigoTipoEmpleado) references TipoEmpleados(codigoTipoEmpleado)
);


Delimiter $$
Create Procedure sp_AgregarEmpleado(
	in numeroEmpleado int,
		in apellidosEmpleado varchar(150),
			in nombresEmpleado varchar(150),
				in direccionEmpleado varchar(150),
					in telefonoContacto varchar(10),
						in gradoCocinero varchar(50),
					in codigoTipoEmpleado int)
				Begin
			Insert into Empleados(numeroEmpleado, apellidosEmpleado, nombresEmpleado , direccionEmpleado, telefonoContacto, gradoCocinero, codigoTipoEmpleado)
		values (numeroEmpleado, apellidosEmpleado, nombresEmpleado, direccionEmpleado, telefonoContacto, gradoCocinero, codigoTipoEmpleado);		
	End $$
Delimiter ;

call sp_AgregarEmpleado('1','Asturias Molina','Nicolas Roberto','1ra.calle 7-20 zona 12','35210789','Chef','1');
call sp_AgregarEmpleado('2','Gonzales Fernandez','Mauricio Manuel','8va.calle 7-50 zona 8','55664120','Saucier','2');
call sp_AgregarEmpleado('3','Reyes Torres','Ignacio Daniel','4ta.calle 8-21 zona 5','45859632','Camarero','3');
call sp_AgregarEmpleado('4','Colon Molina','Thiago Molina','5ta.calle 10-93 zona 19','44659137','Potager','4');
call sp_AgregarEmpleado('5','Kevin Eduardo','Hernandez Donis','11va.calle 5-32 zona 1','42232567','Grillardin','5');



Delimiter $$
	Create Procedure sp_ListarEmpleados()
		Begin
			select
				codigoEmpleado,
					numeroEmpleado, 
						apellidosEmpleado,
							nombresEmpleado,
						direccionEmpleado,
					telefonoContacto,
				gradoCocinero,
			codigoTipoEmpleado
		from Empleados;
	End  $$
Delimiter ;

call sp_ListarEmpleados();

Delimiter $$
	Create Procedure sp_ActualizarEmpleados(in codEmp int, in numEmp int, in apeEmp varchar(150), in nomEmp varchar(150), in dirEmp varchar(150), in telCont varchar(10), in gradCoci varchar(50), in codTipEmp int)
		Begin
			update Empleados
				set
					numeroEmpleado=numEmp,
						apellidosEmpleado=apeEmp,
							nombresEmpleado=nomEmp,
						direccionEmpleado=dirEmp,
					telefonoContacto=telCont,
				gradoCocinero=gradCoci,
			codigoTipoEmpleado=codTipEmp
		where(codigoEmpleado=codEmp);
	End $$
Delimiter ;


Delimiter $$
Create Procedure sp_BuscarEmpleado(codEmp int)
	Begin
		select 
			Empleados.codigoEmpleado,
				Empleados.numeroEmpleado,
					Empleados.apellidosEmpleado,
						Empleados.nombresEmpleado,
							Empleados.direccionEmpleado,
						Empleados.telefonoContacto,
					Empleados.gradoCocinero,
				Empleados.codigoTipoEmpleado
			from Empleados
		where(codigoEmpleado=codEmp);						
	End $$
Delimiter ;




Delimiter $$
	Create Procedure sp_EliminarEmpleado(codEmp int)
		Begin
			delete from Empleados
				where(codigoEmpleado=codEmp);
        End $$
Delimiter ;
-- --------------------------------------------------------------------Servicios_has_Empleados-----------------------------------------------------------------------
Create table Servicios_has_Empleados(
codigoServicio int,
	codigoEmpleado int,
		fechaEvento date,
			horaEvento time,
				lugarEvento varchar(150),
			constraint FK_Servicios_has_Empeleados_Servicios
		foreign key (codigoServicio) references Servicios(codigoServicio),
    constraint FK_Servicios_has_Empleados_Empleados
foreign key (codigoEmpleado) references Empleados(codigoEmpleado)
);


Delimiter $$
	Create procedure sp_AgregarServicios_has_Empleados(
    in codigoServicio int,
		in codigoEmpleado int,
			in fechaEvento date,
				in horaEvento time,
					in lugarEvento varchar(150))
				Begin
			Insert into Servicios_has_Empleados(codigoServicio, codigoEmpleado, fechaEvento, horaEvento, lugarEvento)
		values(codigoServicio, codigoEmpleado, fechaEvento, horaEvento, lugarEvento);
    End$$
Delimiter ;

call sp_AgregarServicios_has_Empleados('1','1','2020-11-25','17:14:35','San Lucas');
call sp_AgregarServicios_has_Empleados('2','2','2020-12-15','14:27:54','Mixco');
call sp_AgregarServicios_has_Empleados('3','3','2021-01-17','10:03:41','Hotel Barcelo');
call sp_AgregarServicios_has_Empleados('4','4','2021-02-02','20:54:10','Jardines de la mansion');
call sp_AgregarServicios_has_Empleados('5','5','2021-03-26','13:36:04','Zoologio Aurora');


Delimiter $$
Create Procedure sp_ListarServicios_has_Empleados()
	Begin
		select 
			codigoServicio,
				codigoEmpleado,
					fechaEvento,
				horaEvento,
			lugarEvento
		from Servicios_has_Empleados;
	End $$
Delimiter ;

call sp_ListarServicios_has_Empleados();

Delimiter $$
Create procedure sp_ActualizarServicios_has_Empleados(in codSer int, in codEmp int, in fechaEve date, in horaEve time, in lugarEve varchar(150))
Begin
	update Servicios_has_Empleados
		set 		
			codigoServicio=codSer,
				codigoEmpleado=codEmp,
					fechaEvento=fechaEve,
				horaEvento=horaEve,
			lugarEvento=lugarEve
        where(codigoServicio=codSer);
	End$$
Delimiter ;


Delimiter $$
Create Procedure sp_BuscarServicios_has_Empleados(codSer int)
	Begin
		select 
			Servicios_has_Empleados.codigoServicio,
				Servicios_has_Empleados.codigoEmpleado,
					Servicios_has_Empleados.fechaEvento,
				Servicios_has_Empleados.horaEvento,
			Servicios_has_Empleados.lugarEvento
		from Servicios_has_Empleados
        where(codigoServicio=codSer);
	End $$
Delimiter ;	

call sp_BuscarServicios_has_Empleados(1);

Delimiter $$
	Create Procedure sp_EliminarServicios_has_Empleados(codSer int)
		Begin
			delete from Servicios_has_Empleados
            where(codigoServicio=codSer);
        End $$
Delimiter ;

-- --------------------------------------------------------Inners Join entidades de union---------------------------------------------------------

drop procedure sp_ListarReportePresupuesto;

Delimiter $$
	Create Procedure sp_ListarReportePresupuesto (in codEmpresa int)
		Begin
			select * from Empresas E inner join Presupuesto P on
					E.codigoEmpresa = P.codigoEmpresa
				inner join Servicios S on
			P.codigoEmpresa = S.codigoEmpresa
		where E.codigoEmpresa = codEmpresa group by S.tipoServicio HAVING COUNT(*) > 1;
	End $$
Delimiter ;

call sp_ListarReportePresupuesto(1);

Delimiter $$
	Create Procedure sp_ListarReporteServicio(in codServ int)
		Begin
			select * from TipoPlato TP inner join Platos P on
				TP.codigoTipoPlato = P.codigoTipoPlato
                inner join Servicios S on 
                P.codigoTipoPlato = S.codigoServicio
                inner join Productos PR on
                P.codigoTipoPlato = PR.codigoProducto
					where S.codigoServicio = codServ;
		End$$
Delimiter ;

call sp_ListarReporteServicio(1);

Delimiter $$
Create Procedure sp_SubReporte(in codEmp int)
	Begin
		Select * from Empresas E inner join Presupuesto P on
			E.codigoEmpresa = P.codigoEmpresa
		where E.codigoEmpresa = codEmp Group by P.cantidadPresupuesto;
	End$$
 Delimiter ;
 
 call sp_SubReporte();
 
 Delimiter $$
	Create Procedure sp_SubReporte2(in codEmp int)
		Begin
			Select * from Empresas E inner join Servicios S on
				E.codigoEmpresa = S.codigoEmpresa
			where E.codigoEmpresa = codEmp;
		End $$
Delimiter ;

call sp_SubReporte2(2);