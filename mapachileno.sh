#!/bin/bash
#definimos constantes
name="mapachile.ps"
r="-73.6/-68.4/-31.4/-26.4" #región
j="M12" #UTM
paleta="ETOPO1.cpt" #colores
grid_file=GMRTv4_2_20240430topo.grd #grilla

#Creamos el marco del mapa
gmt psbasemap -R${r} -J${j} -Ba5g2f1 -Xc -Yc -K -P > ${name}

#Incluimos la grilla y paleta definidas previamente e iluminamos la topografía
gmt grdimage GMRTv4_2_20240430topo.grd -I -R -J -B -C${paleta} -O -K >> ${name}

#Graficamos la línea de costa
gmt pscoast -R${r} -J${j} -Ba5g2f1 -Dh -W0.3,0 -N1 -I4/0.1,39/64/139 -O -K  >> ${name}

# Graficamos la fosa con el archivo trench-chile
gmt psxy trench-chile -R -J -O -W0.2p -Sf0.5i/0.1i+r+t+o1  -Gwhite  -B -K  >> ${name}

# Epicentro del terremoto 2010
echo "-71.44  -28.91" | gmt psxy -R${r} -J${j} -Sa0.8C -W0.5p,0 -Gyellow  -O -K>> ${name}

# Agregamos puntos rojos para las comunas
echo -71.225 -28.463 | gmt psxy -R${r} -J${j} -St0.4C -W0.5p,0 -Gred  -O -K>> ${name}
echo -71.074 -28.205 | gmt psxy -R${r} -J${j} -St0.4C -W0.5p,0 -Gred  -O -K>> ${name}
echo -70.274 -28.836 | gmt psxy -R${r} -J${j} -St0.4C -W0.5p,0 -Gred  -O -K>> ${name}
echo -71.271 -29.879 | gmt psxy -R${r} -J${j} -St0.4C -W0.5p,0 -Gred  -O -K>> ${name}
echo -71.238 -29.904  | gmt psxy -R${r} -J${j} -St0.4C -W0.5p,0 -Gred  -O -K>> ${name}
echo -71.238 -29.919 | gmt psxy -R${r} -J${j} -St0.4C -W0.5p,0 -Gred  -O -K>> ${name}
echo -71.490 -30.259  | gmt psxy -R${r} -J${j} -St0.4C -W0.5p,0 -Gred  -O -K >> ${name}


# Nombres de las estaciones
echo -71.1 -28.463  "A13C - E" | gmt pstext -R${r}  -J${j} -P -F+f10p,Helvetica,black+jLM -Gwhite -O -K >> ${name}
echo -70.95     -28.205  "AC04 - E" | gmt pstext -R${r}  -J${j} -P -F+f10p,Helvetica,black+jLM -Gwhite -O -K >> ${name}
echo -70.15 -28.866  "AC05 - Z" | gmt pstext -R${r}  -J${j} -P -F+f10p,Helvetica,black+jLM -Gwhite -O -K >> ${name}
echo -71.2  -29.73  "C160 - E" | gmt pstext -R${r}  -J${j} -P -F+f10p,Helvetica,black+jLM -Gwhite -O -K >> ${name}
echo -71.15 -29.878  "C170 - N" | gmt pstext -R${r}  -J${j} -P -F+f10p,Helvetica,black+jLM -Gwhite -O -K >> ${name}
echo -71.17  -30.03  "CO05 - E" | gmt pstext -R${r}  -J${j} -P -F+f10p,Helvetica,black+jLM -Gwhite -O -K >> ${name}
echo -71.4 -30.259  "C260 - N" | gmt pstext -R${r}  -J${j} -P -F+f10p,Helvetica,black+jLM -Gwhite -O -K >> ${name}

#Leyenda
#echo -72.8 -27.8 | gmt psxy -R${r} -J${j} -Sa0.4C -W0.5p,0 -Gyellow -O -K>> ${name}
echo -73.2 -27.4 "Epicentro 14/04/24 01:31:42" | gmt pstext -R${r} -J${j} -F+f9p,Arial,black+jLM -Gwhite -O -K >> ${name}
echo -73.2 -27.55 "Estaciones sísmicas" | gmt pstext -R${r} -J${j} -F+f9p,Arial,black+jLM -Gwhite -O -K >> ${name}
echo -73.3 -27.1 "Leyenda" | gmt pstext -R${r} -J${j} -F+f9p,Arial,black+jLM -Gwhite -O -K >> ${name}


# Estrella epicentro
echo -73.3 -27.4 | gmt psxy -R${r} -J${j} -Sa0.4C -W0.2p,0 -Gyellow -O -K >> ${name}

# triangulo de estaciones
echo -73.3  -27.55 | gmt psxy -R${r} -J${j} -St0.4C -W0.2p,0 -Gred -O -P >> ${name}


# Convertir a png
gmt psconvert ${name} -A -Tg -V
