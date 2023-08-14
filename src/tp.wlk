import wollok.game.*
import personaje.*
import puertasYsimilares.*
import nivel.*

object tpIntegrador { 
	var estaSonando=false
	const musica = game.sound("chrono-trigger_YC8KMSzR.mp3")
	var interactuablesNivel = []
	var property nivelDelMomento
	method iniciar(listaDeObjetos) {
		game.width(40) //cantidad de celdas a lo ← ancho →
		game.height(48) //cantidad de celdas a lo ↨ alto ↨
		game.cellSize(16) // Tamaño de cada celda = 16 
		listaDeObjetos.forEach({integrante=>game.addVisual(integrante)})
		listaDeObjetos.remove(baner)
		listaDeObjetos.remove(escenario)
		listaDeObjetos.removeAllSuchThat({integrante=>interactuablesNivel.contains(integrante)})
		game.addVisual(personaje)
		keyboard.down().onPressDo {
			personaje.mover(abajo)
		}
		keyboard.up().onPressDo {
			personaje.mover(arriba)
		}
		keyboard.right().onPressDo {
			personaje.mover(derecha)
		}
		keyboard.left().onPressDo {
			personaje.mover(izquierda)
		}
		keyboard.f().onPressDo { //easter egg
			const silencio = game.sound("silencio-militar.mp3")
			3.times({n=>game.say(personaje,"Presentamos nuestros respetos a los soldados caidos en la materia")})
			silencio.play()
			if (estaSonando){
				musica.pause()
				game.schedule(19000,{=>musica.resume()})
			}
			game.schedule(19000,{=>silencio.stop()})
			
		}
		keyboard.e().onPressDo{
			personaje.variarItemDeLaCabeza()
		}
		keyboard.space().onPressDo{
			const listaCercanos = interactuablesNivel.filter({integrante=>integrante.estaEnCuadrado()})
			if (!listaCercanos.isEmpty() && game.hasVisual(listaCercanos.head())){
				listaCercanos.head().interactuar()
			} else {
				game.say(personaje,"No hay nada cerca")
			}
		}
		keyboard.m().onPressDo{
//			 Para que se repita
			if(musica.paused()){
				musica.resume()
			} else if (musica.played()){
				musica.pause()
			} else {
				musica.play()
			}
			estaSonando=!estaSonando
		}
		game.onCollideDo(personaje,{colisionador=>self.colisionPersonaje(colisionador)})
	}
	
	method iniciarSinPj(listaDeObjetos){
		listaDeObjetos.forEach({integrante=>game.addVisual(integrante)})
		listaDeObjetos.remove(escenario)
	
	}
	
	method jugar() {
//			todosLosLimites.generarListaQueArranca()
			nivelUno.cargarNivel()
			game.start()
	}
	method cambiarNivel(nivelNuevo,listaDeInteractuables,listaDeObjetosDelNivel){
		nivelDelMomento=nivelNuevo
		interactuablesNivel=listaDeInteractuables
		self.iniciar(listaDeObjetosDelNivel)	
	}
	
	method cambiarFondo(nivelNuevo,listaDeObjetosDelNivel){
		nivelDelMomento=nivelNuevo
		self.iniciarSinPj(listaDeObjetosDelNivel)
	}
	
	method colisionPersonaje(colisiona){
		//ver esto por nivelDelMomento
		if (nivelDelMomento.listaDeEmpujables().contains(colisiona)){
			colisiona.mover(personaje.direccion())
		}
	}
}

object escenario {
	var imagen="pepa.png"
	
	method image() {
		return imagen
	}
	method cambiarImagen(imagenAPoner){
		imagen= imagenAPoner
	}
	method position(){
		return game.origin()
	}
}