from fastapi import FastAPI
from app.config.database import engine, Base
from app.routes import cabanas, reservas

# Crear automáticamente las tablas en MySQL si no existen
Base.metadata.create_all(bind=engine)

app = FastAPI(
    title="API Ecoturismo",
    description="API REST para la gestión de reservas y servicios ecoturísticos",
    version="1.0.0"
)

# Incluir Routers
app.include_router(cabanas.router)
app.include_router(reservas.router)

@app.get("/")
def read_root():
    return {"mensaje": "Bienvenido a la API REST de Ecoturismo"}