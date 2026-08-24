---
nombre: Resolución — refutación por contradicción (negar la meta)
parcial: 2P
programa: 2C_2026
tipo: tipo_ejercicio
tema: resolucion
---

# Resolución — refutación por contradicción

## Como reconocer este patron

- El enunciado pide "demostrar por resolución que vale $\phi$"
- O dice "demostrar por refutación / resolución por contradicción"
- La demostración requiere negar la conclusión y llegar a $\square$

## Template de resolucion

```
ALGORITMO:
1. Tener el conjunto de cláusulas S del programa (base de conocimiento)
2. Negar la meta φ: ¬φ → llevar a forma clausal → obtener cláusulas meta
3. Agregar las cláusulas meta a S → S' = S ∪ {cláusulas de ¬φ}
4. Aplicar regla de resolución en pasos:
   - Elegir dos cláusulas C1 y C2 de S'
   - Encontrar un literal L en C1 y ¬L (su complemento) en C2
   - Calcular el MGU σ de L y ¬L
   - Producir la resolvente: (C1 \ {L}) ∪ (C2 \ {¬L}) con σ aplicado
5. Si se obtiene □ (cláusula vacía), la demostración está completa
```

**Formato de presentación:**
```
Cláusula N: {lit1, lit2, ...}  -- Origen (nueva o (i)+(j) con mgu σ)
...
Cláusula K: □                  -- Contradicción
```

**CLAVE — Negación de la meta:**
| Fórmula a demostrar | Negación |
|---|---|
| $\forall X. \phi$ | $\exists X. \neg\phi$ → Skolem: $\neg\phi[X \mapsto c]$ |
| $\exists X. \phi$ | $\forall X. \neg\phi$ → cláusula `{¬φ}` con X libre |
| $A \Rightarrow B$ | $A \wedge \neg B$ |
| $A \wedge B$ | $\neg A \vee \neg B$ → dos metas |

## Por que funciona

La resolución es un sistema de prueba **refutacionalmente completo**: $S \models \phi$ si y solo si $S \cup \{\neg\phi\}$ es insatisfacible. Llegar a $\square$ demuestra que la negación es insatisfacible, lo que prueba $\phi$.

## Apariciones en parciales

- [[parciales_analizados/2.parcial_1C_2024_recuperatorio_resolucion(1)]] — Ej. 1b: refutación de cota inferior con Skolem de función
- [[parciales_analizados/2.parcial_1C_2024_resolucion(1)]] — Ej. 1b: refutación sobre EsDormilon/Posee/Revista con constante de Skolem R
- [[parciales_analizados/2.parcial_2C_2024_resolucion(1)]] — Ej. 2b: refutación para probar ∃M.Tipo(M,γ)
- [[parciales_analizados/2.parcial_2C_2025_resolucion(1)]] — Ej. 2c: refutación de vacío de unión
- [[parciales_analizados/2.parcial_2C_2025_recuperatorio(1)]] — Ej. 2c: refutación sobre melodías y submelodías

## Ejercicios que ejemplifican esto

- [[temas/resolucion_guia]] — Ejercicio 3 (tautologías por resolución)
- [[temas/resolucion_guia]] — Ejercicio 9 (validez en LPO por resolución)
- [[temas/resolucion_practica]] — Ejercicio 2 (propiedades de relaciones)
- [[temas/resolucion_practica]] — Ejercicio 1 (amigos/enemigos, resolución SLD)
