from pydantic import BaseModel, ConfigDict
from datetime import date, datetime
from typing import Optional, List

# --- CABAÑA ---
class CabanaBase(BaseModel):
    cab_num: str
    cab_cap: int
    cab_pre: float
    cab_est: Optional[str] = "A"

class CabanaCreate(CabanaBase):
    pass

class CabanaResponse(CabanaBase):
    cab_id: int
    model_config = ConfigDict(from_attributes=True)

# --- RESERVA ---
class ReservaBase(BaseModel):
    usu_id: int
    hue_id: int
    cab_id: int
    res_fec_ini: date
    res_fec_fin: date
    res_tot: float
    res_est: Optional[str] = "A"

class ReservaCreate(ReservaBase):
    pass

class ReservaResponse(ReservaBase):
    res_id: int
    model_config = ConfigDict(from_attributes=True)