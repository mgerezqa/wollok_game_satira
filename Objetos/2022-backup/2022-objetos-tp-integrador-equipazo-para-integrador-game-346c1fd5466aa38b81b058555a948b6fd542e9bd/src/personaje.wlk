import wollok.game.*

object personaje {
	var posicion
	method position() {
		 posicion = game.origin().up(1)
		 return posicion
	}
	method image() {
		return "beti-chica.png"
	}
	//method moverDerecha(){
		// return posicion.right(8)
	//}
}

object mensajito {
	method position(){
		return game.origin().up(1)
	}
	method image() {
		return "dino2.png"
	}
}

