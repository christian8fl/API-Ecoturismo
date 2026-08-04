from sqlalchemy import Column, Integer, String, Numeric, CHAR, Text, Date, DateTime, ForeignKey
from sqlalchemy.orm import relationship
from app.config.database import Base

class Usuario(Base):
    __tablename__ = "tbl_usuario"

    usu_id = Column(Integer, primary_key=True, index=True, autoincrement=True)
    usu_nombre = Column(String(100), nullable=False)
    usu_correo = Column(String(150), unique=True, nullable=False)
    usu_clave = Column(String(255), nullable=False)
    usu_rol = Column(String(50), default="Recepcionista")
    usu_est = Column(CHAR(1), default="A")

    reservas = relationship("Reserva", back_populates="usuario")

class Huesped(Base):
    __tablename__ = "tbl_huesped"

    hue_id = Column(Integer, primary_key=True, index=True, autoincrement=True)
    hue_nom = Column(String(100), nullable=False)
    hue_ape = Column(String(100), nullable=False)
    hue_cor = Column(String(150), unique=True, nullable=False)
    hue_tel = Column(String(15), nullable=True)
    hue_est = Column(CHAR(1), default="A")

    reservas = relationship("Reserva", back_populates="huesped")

class Cabana(Base):
    __tablename__ = "tbl_cabana"

    cab_id = Column(Integer, primary_key=True, index=True, autoincrement=True)
    cab_num = Column(String(20), unique=True, nullable=False)
    cab_cap = Column(Integer, nullable=False)
    cab_pre = Column(Numeric(10, 2), nullable=False)
    cab_est = Column(CHAR(1), default="A")

    reservas = relationship("Reserva", back_populates="cabana")

class Actividad(Base):
    __tablename__ = "tbl_actividad"

    act_id = Column(Integer, primary_key=True, index=True, autoincrement=True)
    act_nombre = Column(String(100), nullable=False)
    act_descripcion = Column(Text, nullable=True)
    act_precio = Column(Numeric(10, 2), nullable=False)
    act_est = Column(CHAR(1), default="A")

    reserva_actividades = relationship("ReservaActividad", back_populates="actividad")

class Reserva(Base):
    __tablename__ = "tbl_reserva"

    res_id = Column(Integer, primary_key=True, index=True, autoincrement=True)
    usu_id = Column(Integer, ForeignKey("tbl_usuario.usu_id"), nullable=False)
    hue_id = Column(Integer, ForeignKey("tbl_huesped.hue_id"), nullable=False)
    cab_id = Column(Integer, ForeignKey("tbl_cabana.cab_id"), nullable=False)
    res_fec_ini = Column(Date, nullable=False)
    res_fec_fin = Column(Date, nullable=False)
    res_tot = Column(Numeric(10, 2), nullable=False)
    res_est = Column(CHAR(1), default="A")

    usuario = relationship("Usuario", back_populates="reservas")
    huesped = relationship("Huesped", back_populates="reservas")
    cabana = relationship("Cabana", back_populates="reservas")
    actividades = relationship("ReservaActividad", back_populates="reserva")
    pagos = relationship("Pago", back_populates="reserva")

class ReservaActividad(Base):
    __tablename__ = "tbl_reserva_actividad"

    ract_id = Column(Integer, primary_key=True, index=True, autoincrement=True)
    res_id = Column(Integer, ForeignKey("tbl_reserva.res_id"), nullable=False)
    act_id = Column(Integer, ForeignKey("tbl_actividad.act_id"), nullable=False)
    ract_cantidad = Column(Integer, nullable=False, default=1)
    ract_precio_unitario = Column(Numeric(10, 2), nullable=False)
    ract_subtotal = Column(Numeric(10, 2), nullable=False)

    reserva = relationship("Reserva", back_populates="actividades")
    actividad = relationship("Actividad", back_populates="reserva_actividades")

class Pago(Base):
    __tablename__ = "tbl_pago"

    pag_id = Column(Integer, primary_key=True, index=True, autoincrement=True)
    res_id = Column(Integer, ForeignKey("tbl_reserva.res_id"), nullable=False)
    pag_fecha = Column(DateTime, nullable=False)
    pag_monto = Column(Numeric(10, 2), nullable=False)
    pag_metodo = Column(String(50), nullable=False, default="Efectivo")
    pag_est = Column(CHAR(1), default="A")

    reserva = relationship("Reserva", back_populates="pagos")