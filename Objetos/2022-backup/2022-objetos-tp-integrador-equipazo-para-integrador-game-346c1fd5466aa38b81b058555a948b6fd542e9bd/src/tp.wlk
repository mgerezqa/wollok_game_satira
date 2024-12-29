import wollok.game.*
import personaje.*

object tpIntegrador {
	method iniciar() {
		game.width(75) //cantidad de celdas a lo ← ancho →
		game.height(50) //cantidad de celdas a lo ↨ alto ↨
		game.cellSize(16) // Tamaño de cada celda = 16 
		game.boardGround(primerEscenario.png)
		game.addVisualCharacterIn(personaje, game.origin().up(30).right(15)) 
		keyboard.k().onPressDo {
			game.addVisual(mensajito)
		}
		//keyboard.d().onPressDo {
			//personaje.moverDerecha()
		//}
		//keyboard.a().onPressDo {
			//personaje.moverIzquierda()
		//}
		//keyboard.d().onPressDo {
			//personaje.moverDerecha()
		//}
		//keyboard.s().onPressDo {
			//personaje.moverAbajo()
		//}
}
method jugar() {
//		game.addVisualCharacter(personaje) 
		self.iniciar()
		game.start()
		}
	
	}


