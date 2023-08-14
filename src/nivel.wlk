import tp.*
import puertasYsimilares.*
import personaje.*
import wollok.game.*
import posicionesProhibidas.*

class Nivel{
	const imagenEscenario
	var property listaDeEmpujables = []
	var listaDeInteractuables=[]
	var listaDeObjetosDelNivel=[]
	
	method cambiarListaObjetosNivel(listaNueva){
		listaDeObjetosDelNivel=listaNueva
	}
	method cambiarInteractuables(listaNueva){
		listaDeInteractuables=listaNueva
	} 
	method cargarNivel(){
		escenario.cambiarImagen(imagenEscenario)
		// no romper encapsulamiento
		tpIntegrador.cambiarNivel(self,listaDeInteractuables,listaDeObjetosDelNivel)
	}
	
	method cambiarSoloEscenario(){ // necesario para creditos y que no cargue al personaje
		escenario.cambiarImagen(imagenEscenario)
		tpIntegrador.cambiarFondo(self,listaDeObjetosDelNivel)
	}
	method cambiarEmpujables(listaNueva){
		listaDeEmpujables=listaNueva
	}
	//preguntar con puerta por encapsulamiento
	method habilitarPosicion(posicionAHabilitar){
		const deDondeElimina = todasLasZonas.filter({zonaEvaluada=>zonaEvaluada.posicionesDeLaZona().contains(posicionAHabilitar)})
		deDondeElimina.forEach({zona=>zona.eliminarPosicionesDeLaZona(posicionAHabilitar)})
	}
	
	
	method borrarNivel(){
		game.clear()
	}
	
	method finalizarJuego(){
		game.stop()
	}
}


object nivelUno inherits Nivel(imagenEscenario="escenario1_16x16.png") {
	const puertaDeEscape = new Puerta(posicion=game.origin().right(16).up(31),posicionInicio=game.origin().right(16).up(29),nombre="puertaEscape",llevaA=nivelDos,nivelActual=self)
	const puertaCeldaIzq = new PuertaCelda(posicion=game.origin().right(4).up(19),posicionInicio=game.origin().right(4).up(19),nombre="celdaIzq",llevaA=nivelMismo, posicionesQueHabilita=[game.at(5,22),game.at(4,22),game.at(5,19),game.at(4,19)])
	const puertaCeldaDer = new PuertaCelda(posicion=game.origin().right(32).up(19),posicionInicio=game.origin().right(32).up(23),nombre="celdaDer",llevaA=nivelMismo,posicionesQueHabilita=[game.origin().up(22).right(34),game.origin().up(22).right(35),game.origin().up(19).right(35),game.origin().up(19).right(34)])
	const antorchaCeldaIzq = new Agarrables(posicion=game.origin().right(5).up(33),posicionInicio=game.origin().right(4).up(29),nombre = "antorchaPared")
	const antorchaCeldaDer = new Agarrables(posicion=game.origin().right(30).up(33),posicionInicio=game.origin().right(29).up(29),nombre = "antorchaPared")
	const antorchaCelda = new Agarrables(posicion=game.origin().right(14).up(33),posicionInicio=game.origin().right(14).up(29),nombre = "antorchaPared")
	const estandarteCeldaDer = new Soporte(posicion=game.origin().right(38).up(23),posicionInicio=game.origin().right(38).up(21),queActivo= puertaCeldaDer,soportoA= antorchaCeldaDer)
	const estandarteInferior = new Soporte(posicion=game.origin().right(38).up(17),posicionInicio=game.origin().right(38).up(15),queActivo= puertaCeldaIzq,soportoA= antorchaCelda)
	const estandarteCeldaIzq = new Soporte(posicion=game.origin().up(23),posicionInicio=game.origin().up(21),queActivo= puertaDeEscape,soportoA= antorchaCeldaIzq)
	override method cargarNivel(){
		self.cambiarListaObjetosNivel([escenario,baner,banerSuperior,llaveInglesa,puertaDeEscape,puertaCeldaIzq,antorchaCelda,puertaCeldaDer,antorchaCeldaIzq,antorchaCeldaDer,estandarteCeldaIzq,estandarteCeldaDer,estandarteInferior])
		self.cambiarInteractuables([puertaDeEscape,llaveInglesa,antorchaCelda,antorchaCeldaIzq,antorchaCeldaDer,estandarteCeldaDer,estandarteInferior,estandarteCeldaIzq])
		personaje.cambiarPosicionManual(32,28)
		super()
	}
	
}

object nivelDos inherits Nivel(imagenEscenario="escenario2_16x16.png",listaDeObjetosDelNivel=[],listaDeInteractuables=[]){
	const puertaDeEscapeDos = new Puerta(posicion=game.origin().right(7).up(34), posicionInicio=game.origin().right(7).up(34),nombre="puertaDeEscapeDos",llevaA=nivelTres,nivelActual=self)
	const coditoUno = new Codito (orientacionCorrecta=arriba,imagen = "coditoizquierda.png",orientacionActual=izquierda,posicionInicio=game.origin().right(17).up(8), posicion=game.origin().right(19).up(8))
	const coditoDos = new Codito (orientacionCorrecta=abajo,imagen = "coditoIzquierda.png",orientacionActual=izquierda,posicionInicio=game.origin().right(17).up(15), posicion=game.origin().right(19).up(16))
	const coditoTres= new Codito (orientacionCorrecta=izquierda,imagen = "coditoAbajo.png",orientacionActual=derecha,posicionInicio=game.origin().right(23).up(15), posicion=game.origin().right(21).up(16))
	const coditoCuatro= new Codito (orientacionCorrecta=derecha,imagen = "coditoAbajo.png",orientacionActual=abajo,posicionInicio=game.origin().right(23).up(8), posicion=game.origin().right(21).up(8))
	
	const coditoCinco= new Codito (orientacionCorrecta = arriba,imagen = "coditoDerecha.png",orientacionActual=derecha,posicionInicio=game.origin().right(28).up(8), posicion=game.origin().right(30).up(8))
	const coditoSeis= new Codito (orientacionCorrecta = abajo,imagen = "coditoIzquierda.png",orientacionActual=izquierda,posicionInicio=game.origin().right(28).up(15), posicion=game.origin().right(30).up(16))
	const coditoSiete= new Codito (orientacionCorrecta = izquierda,imagen = "coditoIzquierda.png",orientacionActual=izquierda,posicionInicio=game.origin().right(34).up(15), posicion=game.origin().right(32).up(16))
	const coditoOcho = new Codito (orientacionCorrecta = derecha,imagen = "coditoAbajo.png", orientacionActual=abajo,posicionInicio=game.origin().right(34).up(8), posicion=game.origin().right(32).up(8))
	
	const coditoNueve = new Codito (orientacionCorrecta = arriba,imagen = "coditoIzquierda.png", orientacionActual=izquierda,posicionInicio=game.origin().right(36).up(8), posicion=game.origin().right(38).up(8))
	const coditoDiez= new Codito (orientacionCorrecta = arriba,imagen = "coditoIzquierda.png", orientacionActual=izquierda,posicionInicio=game.origin().right(36).up(19), posicion=game.origin().right(38).up(20))
	
	const coditoOnce= new CoditoEspecial (orientacionCorrecta = arriba,imagen = "coditoIzquierda.png", orientacionActual=izquierda,posicionInicio=game.origin().right(16).up(29), posicion=game.origin().right(19).up(29))
	const canilla = new LlavePaso(listaCoditos=[coditoUno,coditoDos,coditoTres,coditoCuatro,coditoCinco,coditoSeis,coditoSiete,coditoOcho,coditoNueve,coditoDiez,coditoOnce])	
	const coditoSuelto= new Empujable (imagen="coditoAbajo.png",posicion=game.origin().up(23).right(5))
	const placaDos = new Placa(posicion=game.origin().right(10).up(10),posicionInicio=game.origin().right(9).up(10),queActiva=puertaDeEscapeDos,queNecesita=coditoSuelto)
//	const posicionesProhibidas = bloqueanteEsc2.posBloq()
	override method cargarNivel(){
		banerSuperior.actualizar("esc2_bannerSuperior.png")
		todasLasZonas.forEach({zona=>zona.cambiarPosicionesNivelDos()})
		self.cambiarListaObjetosNivel([escenario,banerSuperior,baner,personajeAgua,botellaAgua,canilla,coditoSuelto,placaDos,puertaDeEscapeDos,coditoUno,coditoDos,coditoTres,coditoCuatro,coditoCinco,coditoSeis,coditoSiete,coditoOcho,coditoNueve,coditoDiez,coditoOnce])
		self.cambiarInteractuables([personajeAgua,botellaAgua,placaDos,canilla,puertaDeEscapeDos,coditoUno,coditoDos,coditoTres,coditoCuatro,coditoCinco,coditoSeis,coditoSiete,coditoOcho,coditoNueve,coditoDiez,coditoOnce,tablaDeMadera])
		self.cambiarEmpujables([coditoSuelto])
		personaje.cambiarPosicionManual(0,15)
		super()
	}
}

object nivelTres inherits Nivel(imagenEscenario="escenario3_16x16.png"){
	const puertaFinal = new Puerta (nombre="puertaFinal",posicionInicio=game.at(34,33),posicion=game.at(34,35),llevaA=nivelCuatroFinal,nivelActual=self)
	const botonBeti = new Boton(posicion=game.at(24,9),posicionInicio=game.at(23,9),sirvePara=puertaFinal)
//	const posicionesProhibidas = bloqueanteEsc3.posBloq()
	override method cargarNivel(){
		banerSuperior.actualizar("esc3_bannerSuperior.png")
		todasLasZonas.forEach({zona=>zona.cambiarPosicionesNivelTres()})
		personaje.cambiarPosicionManual(7,8)
		self.cambiarEmpujables([peonf2,peonf4,peonb3,reina,rey,torre,peona2])
		self.cambiarInteractuables([botonBeti,puertaFinal,placaTres])
		self.cambiarListaObjetosNivel([escenario,banerSuperior,baner,placaTres,peona2,botonBeti,puertaFinal,rey,peonb3,peonf2,peonf4,reina,peonc2,torre,alfilNegro])
		super()
	}
}

object nivelCuatroFinal inherits Nivel(imagenEscenario="endGame_16x16.png"){
	
	override method cargarNivel(){
	self.cambiarListaObjetosNivel([escenario])
	self.cambiarSoloEscenario()
	keyboard.enter().onPressDo { self.finalizarJuego() }
	}
	
}

object nivelMismo{
	method cargarNivel(){
	}
	method borrarNivel(){	
	}
	method habilitarPosicion(posicionAHabilitar){
		const deDondeElimina = todasLasZonas.filter({zonaEvaluada=>zonaEvaluada.posicionesDeLaZona().contains(posicionAHabilitar)})
		deDondeElimina.forEach({zona=>zona.eliminarPosicionesDeLaZona(posicionAHabilitar)})
	}
}