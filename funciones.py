from decimal import Decimal
from datetime import datetime, timedelta

def calcular_pagos(dato):
    fecha_aprobacion = datetime.strptime(dato['FechaDeAprobacion'], '%Y-%m-%d')
    plazo_pago = dato['PlazoDePago']
    capital_total = dato['Capital']
    intereses = dato['Intereses']
    pago_total = capital_total + intereses
    pago_por_dia = pago_total / plazo_pago

    saldo = capital_total
    for i in range(plazo_pago):
        fecha_pago = fecha_aprobacion + timedelta(days=(i+1)*15)
        if saldo < pago_por_dia:
            pago = saldo
            interes = pago * intereses / pago_total
            capital = pago - interes
        else:
            pago = pago_por_dia
            interes = pago * intereses / pago_total
            capital = pago - interes
        saldo -= capital

