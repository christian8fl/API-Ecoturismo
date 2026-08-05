from fastapi import FastAPI

app = FastAPI(
    title="API Ruta Ecológica Turística Toisán",
    description="Backend para la gestión de ecoturismo, alojamientos, actividades y carrito de compras.",
    version="1.0.0"
)

@app.get("/")
def read_root():
    return {
        "message": "Bienvenido a la API REST de la Ruta Ecológica Turística Toisán",
        "status": "Conectado y funcionando"
    }