from decimal import Decimal
from datetime import datetime, timedelta

def calcular_pagos(datos):
    resultados = []
    for dato in datos:
        fecha_aprobacion = datetime.strptime(dato[0], '%Y-%m-%d')
        contador = dato[1] * 2
        plazo_pago = dato[1] * 2
        capital_total = Decimal(dato[2])
        intereses = Decimal(dato[3])
        pago_total = capital_total + intereses
        pago_por_dia = pago_total / plazo_pago

        saldo = capital_total
        for i in range(plazo_pago):
            fecha_pago = fecha_aprobacion + timedelta(days=(i+1)*15)
            if saldo < pago_por_dia:
                pago = saldo
                interes = pago * intereses / pago_total
                capital = pago 
            else:
                pago = pago_por_dia
                interes = pago * intereses / pago_total
                capital = pago - interes
            saldo -= capital

            resultados.append({
            'Fecha': fecha_pago.strftime('%Y/%m/%d'),
            'Pagos': round(pago, 2),
            'Interes': round(interes, 2),
            'Capital': round(capital, 2),
            'Saldo': round(saldo, 2),
            'contador': (i+1)
        })

    return resultados

