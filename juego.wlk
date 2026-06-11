import wollok.game.*
object juego {
  method iniciar() {
    game.title("Kike Vs Zombies")
    game.width(10)
    game.height(10)
    game.cellSize(100)
    game.ground("pasto.png")

    self.generarEnemigosDeNivel(1)
    self.generarEnemigosDeNivel(2)
    self.generarEnemigosDeNivel(3)

    self.generarComidasDeNivel(1)
    self.generarComidasDeNivel(2)

    kike.aparecer()
    game.onCollideDo(kike, {algo => algo.teCruzasteConKike()})
  }

  method generarEnemigosDeNivel(unNivel) {
    game.schedule(1000, {self.aparecerEnemigoDeNivel(unNivel)})
  }

  method aparecerEnemigoDeNivel(unNivel) {
    const enemigo = new Enemigo(nivel = unNivel)
    enemigo.aparecer()
  }

  method generarComidasDeNivel(unNivel) {
    game.schedule(500, {self.aparecerComidaDeNivel(unNivel)})
  }

  method aparecerComidaDeNivel(unNivel) {
    const comida = new Comida(nivel = unNivel)
    comida.aparecer()
  }
}

object kike {
  var puntos = 0
  var vida = 10

  method puntos() = puntos
  method vida() = vida

  method aparecer() {
    game.addVisualCharacter(self)
  }

  method aumentarPuntos() {
    puntos = puntos + 5
  }

  method perderVida() {
    vida = vida - 1
  }

  method perderVidas(cantidad) {

  }



  var property position = game.origin()

  method image() = "kike.png"
}


class Comida {
    const nivel
    var property position = self.positionAleatoria()

    method positionAleatoria() {
      return (
        game.at(
          0.randomUpTo(game.width()), 0.randomUpTo(game.height())
      )
     )
    }

    method teCruzasteConKike() {
      kike.aumentarPuntos()
      game.say(self, "Ummm que rico, mis puntos son: " + kike.puntos().toString())
    }

    method animarse() {

    }

    method aparecer() {
      game.addVisual(self)
    }

    method image() {
      if (nivel == 1) {
        return "comidita.png"
      } else {
        return "locro.png"
      }
    }
}

class Enemigo {
    const nivel
    var property position = self.positionAleatoria()

    method teCruzasteConKike() {
      kike.perderVida()
      game.say(self, "Auch, me quedan: " + kike.vida().toString() + " vidas.")
    }

    method moverseAleatoriamente() {

    }

    method positionAleatoria() {
      return (
        game.at(
          0.randomUpTo(game.width()), 0.randomUpTo(game.height())
      )
     )
    }

    method aparecer() {
      game.addVisual(self)
    }

    method image() {
      if (nivel == 1) {
        return "perrito.png"
      } else if (nivel == 2) {
        return "perro.png"
      } else {
        return "perrote.png"
      }
    }
}