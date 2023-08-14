import wollok.game.*
import personaje.*
import tp.*
import nivel.*

//class NecesitadosCuadrado{
//	const property ancho
//	const property alto
//	var posicionesCreadas= []
//	const altoDelJuego = (0..48)
//	const anchoDelJuego = (0..40)
//	method generarCuadrilatero(posicion){
//		const todasLasAlturas = [posicion.y(),posicion.y()+alto] + altoDelJuego.filter({n=>n.between(posicion.y(),posicion.y()+alto)})
//		const todasLasAnchuras = [posicion.x(),posicion.x()+ancho] + anchoDelJuego.filter({n=>n.between(posicion.x(),posicion.x()+ancho)})
//		posicionesCreadas=todasLasAlturas.flatMap({posicionY=> self.recorrerListaDeX(posicionY,todasLasAnchuras)})
//	}
//	method crearPosicion(valorDeX,valorDeY){
//		return new Position(x=valorDeX,y=valorDeY) //borrarx=y=
//	}
//	method recorrerListaDeX(valorDeY,listaDeX){
//		return listaDeX.map({valorDeX=>self.crearPosicion(valorDeX,valorDeY)})
//	}
//	method consultarPosicionesCreadas(){
//		return posicionesCreadas
//	}
//}

class Interactuables{
	const posicionInicio
	const alto
	const ancho
	method estaEnCuadrado(){
		const estaEnAlto = personaje.position().y().between(posicionInicio.y(),posicionInicio.y()+alto) //personaje.estaEntre()
		const estaEnAncho = personaje.position().x().between(posicionInicio.x(),posicionInicio.x()+ancho)
		return estaEnAlto && estaEnAncho
	}
}



//lo deje como clase para poder instanciar en nivel 3
class Boton inherits Interactuables(ancho=2,alto=3){
	const posicion
	const sirvePara 
	var imagen = "esc3_Letrero_off.png"
	method position(){
		return posicion
	}
	method image(){
		return imagen
	}
	
	method interactuar(){
		const puedeSerUsado= piezasNivelTres.all({pieza=>pieza.estaEnPosicion()})
		if (puedeSerUsado){
			imagen = "esc3_Letrero_on.png"
			game.removeVisual(personaje)
			sirvePara.activar()
			game.addVisual(personaje)
		} else {
			game.say(personaje, "No puedo usar este boton, la posicion no se resolvio")
		}
	}
}

class PuertaCelda inherits Puerta{
	const posicionesQueHabilita
	override method activar(){
		super()
		posicionesQueHabilita.forEach({posicionHabilitable=> nivelActual.habilitarPosicion(posicionHabilitable)})
	}
	override method interactuar(){
	}
}
class Puerta inherits Interactuables(ancho=2,alto=2){
	var nombre
	const nivelActual = nivelMismo
	const llevaA
	const posicion
	var estaAbierta = false
	method estaAbierta(){
        return estaAbierta
    }
	method position(){
		return posicion
	}
	method activar(){
		estaAbierta = true
		nombre = nombre + "Abierta"
	}
	method image(){
		return nombre + ".png"
	}
	method interactuar(){
		if (estaAbierta){
			nivelActual.borrarNivel()
			llevaA.cargarNivel()
		} else {
			game.say(personaje, "La puerta esta cerrada aun")
		}
	}
}

class PiezasMovibles inherits Empujable{
	const posicionCorrecta
	method estaEnPosicion(){
		return (posicionCorrecta==self.position())
	}
	override method puedeMoverse(){
		const siguiente = personaje.direccion().siguienteEnDireccion(self.position())
		return (self.condicion(siguiente))
	}
	method condicion(posicion)
}

const peonf2= new Peon(posicion=game.at(18,16),posicionInicial=game.at(18,16),posicionCorrecta=game.at(18,16))
const peonf4= new Peon(posicion=game.at(18,22),posicionInicial=game.at(18,22),posicionCorrecta=game.at(18,22))
const peonb3= new Peon(posicion=game.at(6,19),posicionInicial=game.at(6,19),posicionCorrecta=game.at(6,22))	

class Peon inherits PiezasMovibles (imagen="peon.png") {
	const posicionInicial
	override method condicion(siguiente){
		return siguiente.y().between(posicionInicial.y(),posicionInicial.y()+3) && posicionInicial.x()==siguiente.x()
	}
}
//la voluntad estuvo

const alfilNegro = new PiezasInamovibles (imagen = "esc3_alfil_negro.png",posicion = game.at(18,28))
const peona2 = new PiezasInamovibles(imagen ="peon.png",posicion = game.at(3,16))
const peonc2 = new PiezasInamovibles(imagen ="peon.png",posicion = game.at(9,16))
object torre inherits PiezasMovibles(imagen="torre.png",posicion=game.at(18,31),posicionCorrecta=game.at(18,31)) {

	override method condicion(siguiente){
		return ((siguiente.y().between(28,34) && siguiente.x()==18) or (siguiente.x().between(9,21) && siguiente.y()==31))
	}
} 

object rey inherits PiezasMovibles (imagen="rey.png",posicionCorrecta=game.at(6,13),posicion=game.at(6,13)) {
	override method condicion(siguiente){
		return (siguiente.x().between(3,6) && siguiente.y()==13)
	}
}
object reina inherits PiezasMovibles(imagen="reina.png",posicionCorrecta=game.at(9,19),posicion=game.at(9,19)){
	override method condicion(siguiente){
		return (game.getObjectsIn(siguiente).isEmpty())
	}
}



const piezasNivelTres = [peonb3,peonf4,peonf2,reina,rey,torre]

class PiezasInamovibles{
	const posicion
	const imagen
	method position(){
		return posicion
	}
	method image(){
		return imagen
	}
}

class Placa inherits Interactuables(ancho=1,alto=1){
	const queActiva
	const posicion
	const queNecesita
//	const imagen = "placa1Nivel2.jpg"
//	method image(){
//		return imagen
//	}
	method position(){
		return posicion
	}
	method interactuar(){
		const objetoEncima = game.getObjectsIn(self.position())
		if (objetoEncima.contains(queNecesita)){
			queNecesita.cambiarPuedeMoverse()
		 	queActiva.activar()
		} else {
			game.say(personaje,"No tengo lo necesario para poner en la placa")
		}
	}			
}

object habilitadorPosiciones{
	const posicionesQueHabilita = [game.at(35,25),game.at(36,25),game.at(36,27),game.at(35,27)]
	method activar(){
		posicionesQueHabilita.forEach({posicionHabilitable=>nivelTres.habilitarPosicion(posicionHabilitable)})
	}
}
class Soporte inherits Interactuables(ancho=2,alto=4){
	var imagen="antorcha.png"
	const posicion
	const soportoA
	const queActivo
	method image(){
		return imagen
	}
	method interactuar(){
		if (personaje.tieneSeleccionado(soportoA)){
			imagen="antorchaUsada.png"
			personaje.apoyarObjeto(soportoA)
			queActivo.activar()
		} else {
			game.say(personaje,"No")
		}
	}
	method position(){
		return posicion
	}
}
//class Empujable inherits NecesitadosCuadrado(alto=1,ancho=2){
class Empujable{	
	const imagen
	var puedeMoverse=true
	var posicion
	method image(){
		return imagen
	}
	method puedeMoverse(){
		return puedeMoverse
	}
	method cambiarPuedeMoverse(){
		puedeMoverse=!puedeMoverse
	}
	method position(){
		return posicion
	}
	method mover(haciaDonde){
		const paseNomas= haciaDonde.puedePasar(self) 
		if (paseNomas && self.puedeMoverse()){
			posicion = haciaDonde.siguienteEnDireccion(posicion)
		}
		if (!paseNomas){
			personaje.mover(haciaDonde.siguiente().siguiente())
		//esto esta mal
		}
	}
}

class Codito inherits Interactuables(alto=3,ancho=0){
	const orientacionCorrecta
	var imagen
	var orientacionActual
	const posicion
	method image(){
		return imagen
	}
	method position(){
		return posicion
	}
	method estaCorrectamenteOrientado(){
		return orientacionCorrecta==orientacionActual 
	}
	method interactuar(){
		if (personaje.tieneSeleccionado(llaveInglesa)){
			orientacionActual=orientacionActual.siguiente()
			imagen="codito" + orientacionActual.toString() + ".png"
		} else {
			game.say(personaje,"No tengo la herramienta para manipularlo")
		}
	}
}

class CoditoEspecial inherits Codito (alto = 0, ancho = 5)
{} //necesario para el codito 11

class LlavePaso inherits Interactuables(alto=3,ancho=0,posicionInicio=game.origin().right(25).up(27)){
	var listaCoditos
	var imagen = "canillaCERRADA.png"
	method image(){
		return imagen
	}
	method position(){
		return game.origin().right(22).up(31)
	}
	method interactuar(){
			const estamosBien = listaCoditos.all({codito=>codito.estaCorrectamenteOrientado()})	  
			if (estamosBien && personaje.tieneSeleccionado(botellaAgua)){
				imagen = "canillaABIERTA.png"
				game.removeVisual(self)
				game.addVisual(self)
				botellaAgua.llenarBotella()
				game.schedule(1500, {=>imagen = "canillaCERRADA.png"})
				game.removeVisual(self)
				game.addVisual(self)
			} else {
				game.say(personaje,"No puedo hacer nada con esta canilla")
			}
	}
}