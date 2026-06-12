import wollok.game.*
import enemigos.*
import comidas.*

object juego {
  method iniciar() {
    game.title("Kike Vs Zombies")
    game.width(10)
    game.height(10)
    game.cellSize(50)
    game.ground("pasto.png")
    
    self.generarEnemigos()
    self.generarComidas()
    
    kike.aparecer()
    game.onCollideDo(kike, { algo => algo.teCruzasteConKike(algo) })
  }
  
  method generarComidas() {
    self.aparecerComidaHuesoDeNivel(1)
    self.aparecerComidaLocroDeNivel(2)
    self.aparecerComidaPizza(3)
  }
  
  method aparecerComidaPizza(unNivel) {
    const pizza = new Pizza(nivel = unNivel)
    game.schedule(1000, { pizza.aparecer() })
  }
  
  method aparecerComidaHuesoDeNivel(unNivel) {
    const hueso = new HuesoConCarne(nivel = unNivel)
    game.schedule(1000, { hueso.aparecer() })
  }
  
  method aparecerComidaLocroDeNivel(unNivel) {
    const locro = new Locrazo(nivel = unNivel)
    game.schedule(1000, { locro.aparecer() })
  }
  
  method generarEnemigos() {
    self.aparecerEnemigoPerritoDeNivel(1)
    self.aparecerEnemigoPerroDeNivel(2)
    self.aparecerEnemigoPerroteDeNivel(3)
  }
  
  method aparecerEnemigoPerritoDeNivel(unNivel) {
    const perrito = new Perrito(nivel = unNivel)
    game.schedule(1000, { perrito.aparecer() })
  }
  
  method aparecerEnemigoPerroDeNivel(unNivel) {
    const perro = new Perro(nivel = unNivel)
    game.schedule(1000, { perro.aparecer() })
  }
  
  method aparecerEnemigoPerroteDeNivel(unNivel) {
    const perrote = new Perrote(nivel = unNivel)
    game.schedule(1000, { perrote.aparecer() })
  }
}

object kike {
  var property puntos = 0
  var vida = 10
  var property position = game.origin()
  
  method vida() = vida
  
  method text() = "Mi vida: " + vida.toString() + ". " + "Mis puntos: " + puntos.toString() + "."
  
  method aparecer() {
    game.addVisualCharacter(self)
  }
  
  method aumentarPuntosPorToparseCon(unaComida) {
    puntos =+ unaComida.puntosQueOtorga()
  }
  
  method perderVidasPorToparseConEnemigo(unEnemigo) {
    vida -= unEnemigo.vidasQueArrebata()
  }
  
  method aumentarVidas() {
    vida += 1
  }
  
  method image() = "kike.png"
}