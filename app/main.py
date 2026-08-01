from fastapi import FastAPI

app = FastAPI(
    title="Shopping API",
    version="1.0.0"
)

@app.get("/")
def home():
    return {
        "message": "Shopping API funcionando correctamente"
    }

@app.get("/sumar")
def sumar(a: float, b: float):
    return {
        "numero1": a,
        "numero2": b,
        "resultado": a + b
    }