from decimal import Decimal
from datetime import datetime, timedelta

def calcular_pagos(datos):
    resultados = []
    for dato in datos:
        fecha_aprobacion = datetime.strptime(dato[0], '%Y-%m-%d')
        plazo_pago = dato[1] * 2
        capital_total = Decimal(dato[2])
        intereses = Decimal(dato[3])
        pago_total = capital_total + (intereses * capital_total)
        pago_por_dia = pago_total / plazo_pago

        saldo = pago_total  # Saldo inicial es igual al monto del préstamo

        for i in range(plazo_pago):
            fecha_pago = fecha_aprobacion + timedelta(days=(i+1)*15)
            
            if i == plazo_pago - 1:  # Última cuota
                pago = saldo
            elif saldo < pago_por_dia:
                pago = saldo
            else:
                pago = pago_por_dia
            
            interes = (saldo - pago) * intereses / plazo_pago  # Ajustado a la frecuencia mensual (12 meses)
            capital = pago - interes
            saldo -= (capital + interes)

            resultados.append({
                'Fecha': fecha_pago.strftime('%Y/%m/%d'),
                'Pagos': round(pago, 2),
                'Interes': round(interes, 2),
                'Capital': round(capital, 2),
                'Saldo': round(saldo, 2),
                'contador': (i+1)
            })

        # Asegurar que el saldo sea exactamente cero en la última cuota
        ultimo_resultado = resultados[-1]
        saldo_restante = ultimo_resultado['Saldo']

        if saldo_restante > 0:
            ultimo_resultado['Pagos'] += saldo_restante
            ultimo_resultado['Capital'] += saldo_restante
            ultimo_resultado['Saldo'] = 0

        # Redondear el saldo de la última cuota a dos decimales
        ultimo_resultado['Pagos'] = round(ultimo_resultado['Pagos'], 2)
        ultimo_resultado['Interes'] = round(ultimo_resultado['Interes'], 2)
        ultimo_resultado['Capital'] = round(ultimo_resultado['Capital'], 2)
        ultimo_resultado['Saldo'] = round(ultimo_resultado['Saldo'], 2)

    return resultados
