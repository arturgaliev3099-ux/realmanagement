# Spec del skill de negociación (Fase 6) — contrato de respuesta

Skill construido sobre el canon (`canon/`) + la biblioteca de casos (`casos.json`).
Regla de oro: responde SIEMPRE desde el canon y los casos, nunca desde conocimiento
genérico de entrenamiento. El principio y el caso que respaldan cada jugada se EXPLICAN en palabras llanas, no se citan como bibliografía (ver SKILL.md, "El bloque de canon debe ENSEÑAR, no citar").

## Entrada real (asúmela siempre así)
La persona describe su situación en **primera persona, incompleta, subjetiva**: se cuenta
como el bueno, olvida datos, omite (sin querer) su propia parte del problema y su miedo real.
El skill NO toma el relato al pie de la letra: lo **reconstruye**.

## Salida — turno 1 (respuesta completa e inmediata, en este orden)
1. **Te leo la situación real** — devuelve el lío sin el maquillaje: la lucha, los roles,
   de quién es la imagen del mundo que manda, el sólido/hueco, el interés real del otro,
   el miedo que mueve a la persona, y —con TACTO— **su propio hueco/ceguera** (suave en la
   forma, duro en el fondo; nunca darle la razón por complacer). Decisión del usuario:
   CONFRONTAR CON TACTO.
2. **Qué es esto en realidad** — el patrón + la ley/principio del canon que lo gobierna.
3. **La jugada, con palabras exactas** — el movimiento concreto y las frases a decir,
   respaldado por el caso real de la biblioteca que más se parece (cítalo).
4. **Según lo que no me dijiste** — las 2-3 bifurcaciones decisivas, resueltas cada una
   ("si el otro es A → X; si es B → Y"). Esto hace la respuesta completa pese a los huecos.

## Capa de afinado (después de la respuesta, no en vez de ella)
5. **Para afinar** — HASTA 3 preguntas, y solo las que *voltearían* la recomendación
   (no relleno). Van al final, marcadas como opcionales. La persona ya tiene una respuesta
   perfecta y usable sin contestarlas. Decisión del usuario: HASTA 3 PREGUNTAS SI HACEN FALTA.

## Diferencia frente al Claude normal
- Claude normal ante un relato vago: interroga (rompe la promesa) o complace (le da la razón
  al narrador y refuerza su ceguera).
- Este skill: reconoce el patrón contra 275 principios + 949 casos, confronta el autoengaño
  con tacto, y da la jugada con palabras exactas y el caso que la prueba — en el primer mensaje.

## Pendiente para construir en Fase 6
- SKILL.md con este contrato + índice del canon y de los casos como referencia (progressive
  disclosure).
- Motor de diagnóstico: cómo mapear un relato → dominio(s) → principios → casos.
- Modo práctica opcional: correr un role-play y dar retroalimentación estilo Tarásov.
- Evals (Fase 7): relatos vagos reales → ¿la respuesta es canon-grounded, confronta el hueco,
  y es completa sin las 3 preguntas?
