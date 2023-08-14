import tp.*
import puertasYsimilares.*
import personaje.*
import wollok.game.*

//Nivel 1
//const margenIzq = new ObstaculosSinInteraccion(alto=1,ancho=39,posicion=game.origin())
//const margenDerecho = new ObstaculosSinInteraccion(alto=1,ancho=39,posicion=game.origin())
//const precipicio = new ObstaculosSinInteraccion(alto=0,ancho=38,posicion=game.origin().up(10))
//const pared = new ObstaculosSinInteraccion(alto=0,ancho=38,posicion=game.origin().up(31))

//Celda Derecha
//const mesaDer = new ObstaculosSinInteraccion(alto=0,ancho=6,posicion=game.origin().right(33).up(30))
//const camaVasijaAncho = new ObstaculosSinInteraccion(alto=3,ancho=0,posicion=game.origin().up(27).right(28))
//const camaVasijaAlto = new ObstaculosSinInteraccion(alto=0,ancho=2,posicion=game.origin().right(25).up(27))
//const celdaParD = new ObstaculosSinInteraccion(alto=11,ancho=0,posicion=game.origin().right(25).up(19))
//const celdaInfD = new ObstaculosSinInteraccion(alto=0,ancho=13,posicion=game.origin().right(25).up(19))
//const celdaInfD2 = new ObstaculosSinInteraccion(alto=0,ancho=13,posicion=game.origin().right(25).up(22))

//Celda Izq
//const camaIzqAlto = new ObstaculosSinInteraccion(alto=0,ancho=3,posicion=game.origin().right(9).up(28))
//const camaIzqAncho = new ObstaculosSinInteraccion(alto=2,ancho=0,posicion=game.origin().right(9).up(28))
//const celdaParIzq = new ObstaculosSinInteraccion(alto=11,ancho=0,posicion=game.origin().right(12).up(19))
//const celdaInfIzq = new ObstaculosSinInteraccion(alto=0,ancho=11,posicion=game.origin().up(22))
//const celdaInfI2 = new ObstaculosSinInteraccion(alto=0,ancho=11,posicion=game.origin().up(19))

//const portder = new ObstaculosSinInteraccion(alto=0,ancho=5,posicion=game.origin().right(16).up(33))
//const portarriba = new ObstaculosSinInteraccion(alto=2,ancho=0,posicion=game.origin().up(31).right(22))
//const portIzq = new ObstaculosSinInteraccion(alto=2,ancho=0,posicion=game.origin().right(15).up(31))


//const zonaUno = new Zona(limiteIzquierdo=0,limiteDerecho=9,limiteArriba=22,limiteAbajo=8,posicionesEnLaZona=[game.at(0,22),game.at(1,22),game.at(2,22),game.at(3,22),game.at(4,22),game.at(5,22),game.at(6,22),game.at(7,22),game.at(8,22),game.at(9,22),game.at(0,19),game.at(1,19),game.at(2,19),game.at(3,19),game.at(4,19),game.at(5,19),game.at(6,19),game.at(7,19),game.at(8,19),game.at(9,19),game.at(3,20),game.at(3,21),game.at(6,20),game.at(6,20)])
//const zonaDos = new Zona(limiteIzquierdo=10,limiteDerecho=19,limiteArriba=22,limiteAbajo=8,posicionesEnLaZona=[game.at(10,22),game.at(11,22),game.at(12,22),game.at(12,21),game.at(12,20),game.at(12,19),game.at(10,19),game.at(11,19)])
//const zonaTres = new Zona(limiteIzquierdo=20,limiteDerecho=29,limiteArriba=22,limiteAbajo=8,posicionesEnLaZona=[game.at(29,22),game.at(28,22),game.at(27,22),game.at(26,22),game.at(25,22),game.at(25,21),game.at(25,20),game.at(25,19),game.at(26,19),game.at(27,19),game.at(28,19),game.at(29,19)])
//const zonaCuatro = new Zona(limiteIzquierdo=30,limiteDerecho=39,limiteArriba=22,limiteAbajo=8,posicionesEnLaZona=[game.at(30,22),game.at(31,22),game.at(32,22),game.at(33,22),game.at(34,22),game.at(35,22),game.at(36,22),game.at(37,22),game.at(38,22),game.at(39,22),game.at(30,19),game.at(31,19),game.at(32,19),game.at(33,19),game.at(34,19),game.at(35,19),game.at(36,19),game.at(37,19),game.at(38,19),game.at(39,19),game.at(33,20),game.at(36,20),game.at(33,21),game.at(36,21)])

object bloqueanteZonaOcho {
    const lista = (33..39).map { x => game.at(x,30) } //Mesa y Silla
    const lista2 = (30..39).map { x => game.at(x,31) } //Pared

    method lista() = lista+lista2
}

object bloqueanteZonaSiete{
    const lista = (23..29).map { x => game.at(x,31) } //Pared
    const lista2 = (23..24).map { x => game.at(x,32) } //Marco Puerta
    const lista3 = (20..29).map { x => game.at(x,33) } // Puerta
    const lista4 = (23..38).map { y => game.at(25,y) } // Pared vertical celda derecha
    const lista5 = (25..31).map { y => game.at(28,y) } //Cama derecha y caldero
    const lista6 = (26..28).map { x => game.at(x,25) } //Cama derecha y caldero
    method lista() = lista+lista2+lista3+lista4+lista5+lista6
}

object bloqueanteZonaSeis{
	const lista = (10..16).map { x => game.at(x,31) } //Pared
    const lista2 = (15..16).map { x => game.at(x,32) } //Marco Puerta
	const lista3 = (10..19).map { x => game.at(x,33) } // Puerta
	const lista4 = (23..38).map { y => game.at(12,y) } // Pared vertical celda izquierda
	const lista5 = (10..11).map { x => game.at(x,28) } //Cama izquierda
	
    method lista() = lista+lista2+lista3+lista4+lista5
} 

object bloqueanteZonaCinco{
	const lista = (0..9).map { x => game.at(x,31) } //Pared
	const lista2 = (28..31).map { y => game.at(9,y) } //Cama izquierda
	const lista3 = (1..3).map { x => game.at(x,30) } //Caldero
	const lista4 = (30..31).map { y => game.at(1,y) } //Caldero
	const lista5 = (30..31).map { y => game.at(3,y) } //Caldero
    method lista() = lista+lista2+lista3+lista4+lista5
}

object bloqueanteZonaCuatro{
	const lista = (30..39).map { x => game.at(x,22) } // Pared horizontal celda derecha
	const lista2 = (30..39).map { x => game.at(x,19) } // Pared horizontal celda derecha
	const lista3 = (19..22).map { y => game.at(33,y) } // Puerta celda derecha
	const lista4 = (19..22).map { y => game.at(35,y) } // Puerta celda derecha
	
	method lista() = lista+lista2+lista3+lista4
}

object bloqueanteZonaTres{
	const lista = (25..29).map { x => game.at(x,22) } // Pared horizontal celda derecha
	const lista2 = (25..29).map { x => game.at(x,19) } // Pared horizontal celda derecha
	method lista() = lista+lista2
}

object bloqueanteZonaDos{
	const lista = (10..12).map { x => game.at(x,22) } // Pared horizontal celda izquierda
	const lista2 = (19..22).map { y => game.at(12,y) } // Pared vertical celda izquierda
	const lista3 = (10..12).map { x => game.at(x,19) } // Pared horizontal celda izquierda
	
	method lista() = lista+lista2+lista3
}

object bloqueanteZonaUno{
	const lista = (0..9).map { x => game.at(x,22) } // Pared horizontal celda izquierda
	const lista2 = (0..9).map { x => game.at(x,19) } // Pared horizontal celda izquierda
	const lista3 = (19..22).map { y => game.at(3,y) } // Puerta celda izquierda
	const lista4 = (19..22).map { y => game.at(5,y) } // Puerta celda izquierda
	
	method lista() = lista+lista2+lista3+lista4
}

const zonaUno = new Zona(limiteIzquierdo=0,limiteDerecho=9,limiteArriba=22,limiteAbajo=8,posicionesEnLaZona=bloqueanteZonaUno.lista(),posicionesNivelDos=[game.at(0,13),game.at(0,13),game.at(1,13), game.at(2,13),game.at(3,13),game.at(4,13),game.at(3,9),game.at(4,9),game.at(5,9),game.at(6,9),game.at(7,9),game.at(8,9),game.at(9,9),game.at(4,9),game.at(4,10),game.at(4,11),game.at(4,12), game.at(4,13),game.at(0,17),game.at(1,17), game.at(2,17), game.at(3,17),game.at(3,18),game.at(3,19), game.at(3,20), game.at(3,21), game.at(3,22), game.at(7,22), game.at(8,22), game.at(9,22),game.at(8,19),game.at(9,19), game.at(7,19), game.at(7,20), game.at(7,21), game.at(7,22)],posicionesNivelTres = [game.at(2,8),game.at(2,9),game.at(2,10),game.at(2,11),game.at(1,13),game.at(2,14),game.at(2,15),game.at(2,12),game.at(2,16),game.at(2,17),game.at(2,18),game.at(2,19),game.at(2,20),game.at(2,21),game.at(2,22), game.at(5,19),game.at(5,20),game.at(4,16),game.at(3,16),game.at(5,16),game.at(5,17),game.at(5,18),game.at(3,21),game.at(4,21),game.at(5,21)])
const zonaDos = new Zona(limiteIzquierdo=10,limiteDerecho=19,limiteArriba=22,limiteAbajo=8,posicionesEnLaZona=bloqueanteZonaDos.lista(),posicionesNivelDos = [game.at(10,9), game.at(11,9),game.at(12,9),game.at(12,12),game.at(13,12), game.at(14,9), game.at(15,9), game.at(16,9), game.at(17,9), game.at(18,9), game.at(19,9), game.at(18,17), game.at(19,17), game.at(11,10), game.at(11,11), game.at(11,12), game.at(13,10), game.at(13,11), game.at(13,12), game.at(18,10), game.at(18,11), game.at(18,12), game.at(18,13), game.at(18,14), game.at(18,15), game.at(18,16), game.at(18,17), game.at(17,22), game.at(18,22), game.at(19,22), game.at(10,22), game.at(11,22), game.at(12,22), game.at(13,22), game.at(10,19), game.at(11,19), game.at(12,19), game.at(13,19), game.at(13,19), game.at(13,20), game.at(13,21), game.at(13,22)],posicionesNivelTres = [])
const zonaTres = new Zona(limiteIzquierdo=20,limiteDerecho=29,limiteArriba=22,limiteAbajo=8,posicionesEnLaZona=bloqueanteZonaTres.lista(),posicionesNivelDos = [game.at(20,17), game.at(21,17), game.at(22,17), game.at(22,9), game.at(23,9), game.at(24,9), game.at(25,9), game.at(26,9), game.at(27,9), game.at(28,9), game.at(29,9), game.at(22,10), game.at(22,11), game.at(22,12), game.at(22,13), game.at(22,14), game.at(22,15), game.at(22,16), game.at(22,17), game.at(29,10), game.at(29,11), game.at(29,12), game.at(29,13), game.at(29,14), game.at(29,15), game.at(29,16), game.at(29,17), game.at(23,22), game.at(20,22), game.at(21,22), game.at(22,22)],posicionesNivelTres = [game.at(27,11),game.at(27,12),game.at(27,13),game.at(27,14),game.at(27,15),game.at(27,16),game.at(27,17),game.at(27,18),game.at(27,19),game.at(27,20),game.at(27,21),game.at(27,22),game.at(27,10),game.at(28,10),game.at(29,10)])
const zonaCuatro = new Zona(limiteIzquierdo=30,limiteDerecho=39,limiteArriba=22,limiteAbajo=8,posicionesEnLaZona=bloqueanteZonaCuatro.lista(),posicionesNivelDos = [game.at(29,11), game.at(29,12), game.at(29,13), game.at(29,14), game.at(29,15), game.at(29,16), game.at(29,17), game.at(23,22), game.at(20,22), game.at(21,22), game.at(22,22),game.at(37,12), game.at(37,13), game.at(37,14), game.at(37,15), game.at(37,16), game.at(37,17), game.at(37,18), game.at(37,19), game.at(37,20), game.at(37,21), game.at(37,22), game.at(35,22), game.at(36,22), game.at(37,22), game.at(38,22),game.at(30,17),game.at(31,17),game.at(32,17),game.at(33,17),game.at(33,16),game.at(37,11),game.at(37,10),game.at(36,9),game.at(35,9),game.at(34,9),game.at(33,10),game.at(33,11),game.at(33,12),game.at(33,13),game.at(33,14),game.at(33,15)],posicionesNivelTres = [game.at(30,10), game.at(31,10), game.at(31,10), game.at(31,11), game.at(31,12), game.at(31,13), game.at(31,14), game.at(31,15), game.at(31,16), game.at(31,17), game.at(31,18), game.at(31,19), game.at(32,19), game.at(32,20), game.at(32,21), game.at(32,22), game.at(38,19), game.at(38,20), game.at(38,21), game.at(38,22), game.at(31,19), game.at(32,19), game.at(38,19), game.at(39,19)])
const zonaCinco = new Zona(limiteIzquierdo=0,limiteDerecho=9,limiteArriba=38,limiteAbajo=23,posicionesEnLaZona=bloqueanteZonaCinco.lista(),posicionesNivelDos =[game.at(30,17),game.at(31,17),game.at(32,17),game.at(33,17),game.at(33,16),game.at(33,15),game.at(33,14),game.at(33,13),game.at(33,12),game.at(33,11),game.at(33,10),game.at(34,9),game.at(35,9),game.at(36,9),game.at(37,9),game.at(3,23), game.at(3,24), game.at(3,25), game.at(3,26),game.at(3,27),game.at(3,28),game.at(3,29),game.at(3,30),game.at(3,31),game.at(3,32),game.at(3,33),game.at(3,34),game.at(3,35),game.at(2,34),game.at(4,34),game.at(5,34),game.at(6,34),game.at(7,34),game.at(9,34),game.at(7,35),game.at(7,36),game.at(7,37),game.at(9,34),game.at(9,35),game.at(9,36),game.at(9,37),game.at(6,35),game.at(8,35)],posicionesNivelTres = [game.at(8,31),game.at(8,32),game.at(8,33),game.at(8,34),game.at(8,35),game.at(8,36),game.at(7,31),game.at(2,23),game.at(2,24),game.at(2,25),game.at(2,26),game.at(2,27),game.at(6,31),game.at(3,28),game.at(4,28),game.at(5,28),game.at(5,29),game.at(5,30)])
const zonaSeis = new Zona(limiteIzquierdo=10,limiteDerecho=19,limiteArriba=38,limiteAbajo=23,posicionesEnLaZona=bloqueanteZonaSeis.lista(),posicionesNivelDos = [game.at(10,34),game.at(11,34),game.at(12,34),game.at(12,32),game.at(13,32),game.at(14,32),game.at(15,32),game.at(16,32),game.at(17,32),game.at(18,32),game.at(11,32),game.at(11,33),game.at(11,34),game.at(11,35),game.at(17,23),game.at(17,24),game.at(17,25),game.at(17,26),game.at(17,27),game.at(17,28),game.at(17,29),game.at(17,30),game.at(17,31),game.at(17,32),game.at(17,33),game.at(17,35)],posicionesNivelTres = [game.at(10,37), game.at(11,37), game.at(12,37), game.at(13,37), game.at(14,37), game.at(15,37), game.at(16,37), game.at(17,37), game.at(18,37), game.at(19,37)])
const zonaSiete = new Zona(limiteIzquierdo=20,limiteDerecho=29,limiteArriba=38,limiteAbajo=23,posicionesEnLaZona=bloqueanteZonaSiete.lista(),posicionesNivelDos = [game.at(23,23),game.at(23,24),game.at(23,25),game.at(24,23),game.at(24,24),game.at(24,25),game.at(24,26),game.at(24,27),game.at(24,28),game.at(24,29),game.at(24,30),game.at(24,31),game.at(24,32),game.at(24,33),game.at(25,32),game.at(26,32),game.at(27,32),game.at(28,32),game.at(29,32),game.at(27,33),game.at(27,34)],posicionesNivelTres = [game.at(27,23),game.at(27,24),game.at(27,25),game.at(27,26),game.at(27,27),game.at(27,28),game.at(27,29),game.at(27,30),game.at(27,31),game.at(27,32),game.at(27,33),game.at(27,34),game.at(27,35),game.at(27,36),game.at(27,37),game.at(27,38),game.at(20,37),game.at(21,37),game.at(22,37),game.at(23,37),game.at(24,37),game.at(25,37),game.at(26,37),game.at(29,37),game.at(23,28),game.at(23,29),game.at(23,30),game.at(24,28),game.at(25,28),game.at(26,28),game.at(27,28),game.at(28,28),game.at(23,30),game.at(24,30),game.at(25,30),game.at(26,30),game.at(27,30),game.at(28,30)])
const zonaOcho = new Zona(limiteIzquierdo=30,limiteDerecho=39,limiteArriba=38,limiteAbajo=23,posicionesEnLaZona = bloqueanteZonaOcho.lista(),posicionesNivelDos = [game.at(37,23),game.at(30,32),game.at(31,32),game.at(32,32),game.at(33,32),game.at(34,32),game.at(35,32),game.at(36,32),game.at(37,32),game.at(35,23),game.at(35,24),game.at(35,25),game.at(35,26),game.at(35,27),game.at(35,28),game.at(35,39),game.at(35,30),game.at(35,31),game.at(35,32),game.at(35,33),game.at(35,34)],posicionesNivelTres =[game.at(32,23),game.at(32,24),game.at(32,25),game.at(32,26),game.at(32,27),game.at(32,28),game.at(32,29),game.at(38,23),game.at(38,24),game.at(38,25),game.at(38,26),game.at(38,27),game.at(38,28),game.at(38,29),game.at(31,30),game.at(31,31),game.at(31,32),game.at(31,33),game.at(31,34),game.at(31,35),game.at(31,36),game.at(31,37),game.at(31,38),game.at(30,29),game.at(38,29),game.at(39,29),game.at(31,35),game.at(32,35),game.at(33,35),game.at(34,35),game.at(36,35),game.at(37,35),game.at(38,35),game.at(39,35),game.at(34,36),game.at(35,36),game.at(36,36),game.at(34,35),game.at(34,37),game.at(36,35),game.at(36,37),game.at(36,36),game.at(33,25),game.at(34,25),game.at(35,25),game.at(36,25),game.at(37,25)] )
////PAREDD
//[game.at(30,31),game.at(31,31),
////VASIJAD 
//game.at(27,26),game.at(27,26),
////JUEGO MESA D
//game.at(33,30),game.at(34,30),game.at(35,30),game.at(36,30),game.at(37,30),game.at(38,30),
////CAMA D
//game.at(26,28),game.at(27,28),game.at(28,28),game.at(29,28),game.at(29,29),game.at(29,30),
//
////PRECIPICIO
//game.at(0,12),game.at(1,12),game.at(2,12),game.at(3,12),game.at(4,12),game.at(5,12),game.at(6,12),game.at(7,12),game.at(8,12),game.at(9,12),game.at(10,12),game.at(11,12),game.at(12,12),game.at(13,12),game.at(14,12),game.at(15,12),game.at(16,12),game.at(17,12),game.at(18,12),game.at(19,12),game.at(20,12),game.at(21,12),game.at(22,12),game.at(23,12),game.at(24,12),game.at(25,12),game.at(26,12),game.at(27,12),game.at(28,12),game.at(29,12),game.at(30,12),game.at(31,12),game.at(32,12),game.at(33,12),game.at(34,12),game.at(35,12),game.at(36,12),game.at(37,12),game.at(38,12)])
