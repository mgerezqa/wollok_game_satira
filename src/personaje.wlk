import wollok.game.*
import puertasYsimilares.*
import tp.*
import nivel.*
import posicionesProhibidas.*

object personaje {
	var direccionActual =abajo
	var posicion = game.origin().up(27).right(26)
	var imagen = "stand.png"
	var objetosDisponibles = []
	method position(){
		return posicion
	}
	method cambiarDireccion(nueva){
		direccionActual=nueva
	}
	method direccion(){
		return direccionActual
	}
	method usadoElElemento(elemento){
			objetosDisponibles.remove(elemento)
	} //antes lo hacia tpIntegrador
	method cambiarPosicionManual(ejeX,ejeY){
		posicion = new Position(x=ejeX,y=ejeY)
	}
	method variarItemDeLaCabeza(){
		if (objetosDisponibles.isEmpty()){
		} else if (objetosDisponibles.size()==1){
			if (!game.hasVisual(objetosDisponibles.head())){
				game.addVisual(objetosDisponibles.head())
			}
		} else {
				//redujimos
				const cabecera = objetosDisponibles.head()
				if (game.hasVisual(cabecera)){
					game.removeVisual(cabecera)
				}
				objetosDisponibles = objetosDisponibles.drop(1)
				game.addVisual(objetosDisponibles.head())
				objetosDisponibles = objetosDisponibles + [cabecera] 
		}
	}
	method mover(haciaDonde){
		const paseNomas= haciaDonde.puedePasar(self) 
		if (paseNomas){
			posicion = haciaDonde.siguienteEnDireccion(posicion)
			haciaDonde.moverImagen()
			self.cambiarDireccion(haciaDonde)
		}
	}
	method cambiarImagen(imagenAPoner){
		imagen= imagenAPoner
	}
	method caminar(imagenAPoner1, imagenAPoner2){
		if (imagen == imagenAPoner1){
			self.cambiarImagen(imagenAPoner2)
			game.schedule(400, {=>self.cambiarImagen("stand.png")})}
		else {
			self.cambiarImagen(imagenAPoner1)
			game.schedule(400, {=>self.cambiarImagen("stand.png")})}
	}
	method image() {
		return imagen
	}
	method agregarALista(objeto){
		objetosDisponibles.add(objeto)
	}
	method listaDeObjetos(){
		return objetosDisponibles
	}
	method apoyarObjeto(objeto){
		game.removeVisual(objeto)
		objetosDisponibles.remove(objeto)
	}
	method tieneSeleccionado(objeto){
		return (objetosDisponibles.contains(objeto) && game.hasVisual(objeto)) 
	}
}

class Agarrables inherits Interactuables(alto=1,ancho=2,posicionInicio=game.origin().up(15).right(18)){
	const nombre
	var posicion = game.origin().up(17).right(18)
	var property estaEnElInventario = false
	method preguntarNombre(){
		return nombre
	}
	method position() {
		if (estaEnElInventario) {
			posicion = personaje.position().up(4).left(1)
		}
		return posicion
	}
	method image(){
		return nombre + ".png"
	}
	method interactuar(){
		if (!estaEnElInventario){
			game.removeVisual(self)
			estaEnElInventario = true
			personaje.agregarALista(self)
		}
	}
}

object placaTres inherits Soporte(posicion=game.at(35,23),posicionInicio=game.at(34,23),imagen = "espacioPlaca3.png",queActivo=habilitadorPosiciones,soportoA=tablaDeMadera){
	override method interactuar(){
		tablaDeMadera.apoyarObjeto()
	}
}

class HerramientaPura inherits Agarrables{
	override method interactuar() {
		super()
		baner.actualizar("esc1_bannerInferiorCon"+nombre+".png")
	}
}

const llaveInglesa = new HerramientaPura(nombre="llaveInglesa")



object botellaAgua inherits Agarrables(alto= 1,ancho = 2, nombre = "botellaAgua",posicion=game.origin().right(10).up(20),posicionInicio=game.origin().right(10).up(18)){
	var property estaLleno = false
	var imagen = nombre + "Vacia.png" 
	override method image(){
		return imagen
	}
	method llenarBotella(){
		estaLleno = true
		imagen= nombre +"Llena.png"
		game.removeVisual(self)
		game.addVisual(self)
	}
}

object personajeAgua inherits Interactuables(alto=3,ancho=3,posicionInicio=game.origin().up(26).right(10)){
	const imagen ="esc2_PersonaAgua.png"
	const posicion = game.origin().up(27).right(11)
	method image(){
		return imagen
	}
	method position(){
		return posicion
	}
	method interactuar(){
		if (botellaAgua.estaLleno()){
			game.schedule(400, {=>game.say(self,"Valar Dohaeris")})		
			game.removeVisual(botellaAgua)
			personaje.usadoElElemento(botellaAgua)
			game.addVisual(tablaDeMadera)
			game.removeVisual(personaje)
			game.addVisual(personaje)
		} else {
			game.say(self,"SOY EL MONSTRUO DE AGUA, DEBO TOMAR AGUA PARA VIVIR")
		}
			
	}
}

object abajo inherits Direccion(imagenCorriendo1="up_1.png",imagenCorriendo2="up_2.png",siguiente=izquierda){
	 override method siguienteEnDireccion(posicion) = posicion.down(1)
}

object arriba inherits Direccion(imagenCorriendo1= "up_1.png",imagenCorriendo2="up_2.png",siguiente=derecha ){
	override method siguienteEnDireccion(posicion) = posicion.up(1)
}

class Direccion{
	const property siguiente
	const imagenCorriendo1
	const imagenCorriendo2
	method moverImagen(){
		personaje.caminar(imagenCorriendo1,imagenCorriendo2)
	}
	method siguienteEnDireccion(posicion)
	method puedePasar(quienMueve){
			const cualSigue= self.siguienteEnDireccion(quienMueve.position())
			const entreBordes = cualSigue.y().between(8,38) && cualSigue.x().between(0,39)
			if (!entreBordes){
				return false
			}
			// esto es para que no evalue innecesariamente lo que sigue 
			const enQueZonaEsta = todasLasZonas.filter({integrante=>integrante.estaEnZona(cualSigue)}).head()
			return !enQueZonaEsta.estaProhibida(cualSigue)
	}
	
}
object izquierda inherits Direccion(imagenCorriendo1="left_1.png",imagenCorriendo2="left_2.png",siguiente=arriba){
	override method siguienteEnDireccion(posicion) = posicion.left(1)
}

object derecha inherits Direccion(imagenCorriendo1="right_1.png",imagenCorriendo2="right_2.png",siguiente=abajo){
	override method siguienteEnDireccion(posicion) = posicion.right(1)
}


//class Direccion{
//	const imagen1
//	const imagen2
//	const siguiente
//	method cambiarDireccion(){
//		personaje.cambiarDireccion(self)
//	}
//	method moverImagen(){
//		personaje.caminar(imagen1,imagen2)
//	}
//	method siguiente(){
//		return siguiente
//	}
//} el problema es poner up, down, etc

const todasLasZonas = [zonaUno,zonaDos,zonaTres,zonaCuatro,zonaCinco,zonaSeis,zonaSiete,zonaOcho]

class Zona{
	const limiteIzquierdo
	const limiteDerecho
	const limiteArriba
	const limiteAbajo
	const posicionesNivelDos
	const posicionesNivelTres
	var posicionesEnLaZona
	method estaEnZona(posicion){
		return posicion.y().between(limiteAbajo,limiteArriba) && posicion.x().between(limiteIzquierdo,limiteDerecho)
	}
	method eliminarPosicionesDeLaZona(posicion){
		posicionesEnLaZona.remove(posicion)
	}
	method cambiarPosicionesDeLaZona(posiciones){
		posicionesEnLaZona=posiciones
	}
	method cambiarPosicionesNivelDos(){
		posicionesEnLaZona = posicionesNivelDos
	}
	method cambiarPosicionesNivelTres(){
		posicionesEnLaZona = posicionesNivelTres
	}
	method estaProhibida(posicion){
		return posicionesEnLaZona.contains(posicion)
	}
	method posicionesDeLaZona(){
		return posicionesEnLaZona
	}
	method evaluarPosicionesDeLaZona(posicionesLista){
		const aEliminar = posicionesLista.filter({posicion=>self.estaEnZona(posicion)})
		self.cambiarPosicionesDeLaZona(aEliminar)
	}
}

const banerSuperior = new Baner(posicion=game.origin().up(40),imagen="esc1_bannerSuperior.png")
object baner inherits Baner(posicion=game.origin(),imagen="esc1_bannerInferior.png"){
	override method actualizar(imagenNueva){
		super(imagenNueva)
		game.removeVisual(self)
		game.addVisual(self)
	}
}


class Baner{
	var imagen 
	const posicion
	method image(){
		return imagen
	}
	method position(){
		return posicion
	}
	method actualizar(imagenNueva){
		imagen = imagenNueva
	}
}

object tablaDeMadera inherits HerramientaPura(posicion= game.origin().right(8).up(24),posicionInicio=game.origin().right(8).up(24),nombre="tablaDeMadera"){
	method apoyarObjeto(){
		if (personaje.position().distance(placaTres.position())<=2){
			game.removeVisual(self)
			game.removeVisual(personaje)
			game.addVisualIn(self,placaTres.position())
			personaje.usadoElElemento(self)
			game.addVisual(personaje)
			habilitadorPosiciones.activar()
		}
	}
}