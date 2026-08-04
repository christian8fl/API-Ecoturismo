from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from typing import List
from app.config.database import get_db
from app.models.models import Cabana
from app.schemas.schemas import CabanaCreate, CabanaResponse

router = APIRouter(prefix="/cabanas", tags=["Cabañas"])

@router.get("/", response_model=List[CabanaResponse])
def listar_cabanas(db: Session = Depends(get_db)):
    return db.query(Cabana).all()

@router.post("/", response_model=CabanaResponse, status_code=status.HTTP_201_CREATED)
def crear_cabana(cabana: CabanaCreate, db: Session = Depends(get_db)):
    nueva_cabana = Cabana(**cabana.model_dump())
    db.add(nueva_cabana)
    db.commit()
    db.refresh(nueva_cabana)
    return nueva_cabana