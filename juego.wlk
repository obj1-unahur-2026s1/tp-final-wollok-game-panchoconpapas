import wollok.game.*
import enemigos.*
import comidas.*
import obstaculos.*
import elementos.*

object juego {
  const listaDeEnemigos = []
  const listaDeElementos = []
  const sonidoAmbiente = game.sound("kikeSound.mp3")
  var property dificultad = 1
  var juegoEnMarcha = false
  
  method musica() = sonidoAmbiente
  
  method iniciar() {
    self.iniciarEscenario()
    self.iniciarPantallaPrincipal()
  }
  
  method iniciarEscenario() {
    sonidoAmbiente.volume(0.025)
    sonidoAmbiente.play()
    game.title("Kike Game")
    game.width(10)
    game.height(10)
    game.cellSize(50)
    game.ground("pasto.png")
    game.start()
  }
  
  method iniciarPantallaPrincipal() {
    if (not game.hasVisual(pantallaPrincipal)) pantallaPrincipal.mostrar()
    self.teclasDeControl()
  }
  
  method teclasDeControl() {
    keyboard.enter().onPressDo(
      { if (!juegoEnMarcha) {
          juegoEnMarcha = true
          game.removeVisual(pantallaPrincipal)
          self.iniciarJuego()
        } }
    )
    
    keyboard.c().onPressDo(
      { if (!juegoEnMarcha) {
          juegoEnMarcha = true
          game.removeVisual(pantallaPrincipal)
          game.addVisual(controles)
          keyboard.m().onPressDo(
            { 
              game.removeVisual(controles)
              juegoEnMarcha = false
              self.iniciarPantallaPrincipal()
            }
          )
        } }
    )
    
    keyboard.i().onPressDo(
      { if (!juegoEnMarcha) {
          juegoEnMarcha = true
          game.removeVisual(pantallaPrincipal)
          game.addVisual(instrucciones)
          keyboard.m().onPressDo(
            { 
              game.removeVisual(instrucciones)
              juegoEnMarcha = false
              self.iniciarPantallaPrincipal()
            }
          )
        } }
    )
    
    keyboard.d().onPressDo(
      { if (!juegoEnMarcha) {
          juegoEnMarcha = true
          game.removeVisual(pantallaPrincipal)
          game.addVisual(dificultades)
          self.teclasDificultades()
          keyboard.m().onPressDo(
            { 
              game.removeVisual(dificultades)
              juegoEnMarcha = false
              self.iniciarPantallaPrincipal()
            }
          )
        } }
    )
    
    keyboard.r().onPressDo(
      { 
        game.removeVisual(kike)
        game.removeVisual(marcador)
        game.removeVisual(marcadorFinal)
        game.clear()
        return self.iniciarJuego()
      }
    )
  }
  
  method teclasDificultades() {
    keyboard.b().onPressDo({   juegoEnMarcha = false; self.dificultad(1)})
    keyboard.f().onPressDo({   juegoEnMarcha = false; self.dificultad(2)})
  }
  
  method iniciarJuego() {
    self.teclasDeControl()
    if (not game.hasVisual(kike)) kike.aparecer()
    marcadorFinal.aparecer()
    game.onTick(
      1000,
      "moverse",
      { listaDeEnemigos.forEach({ enemigo => enemigo.movete() }) }
    )
    game.onCollideDo(
      kike,
      { elemento => elemento.teCruzasteCon(kike, elemento) }
    )
    self.generarElementos()
    marcador.aparecer()
    self.configs()
  }
  
  method generarElementos() {
    2.times({ i => self.generarEnemigos() })
    
    25.times({ i => self.agregarObstaculo() })
    5.times({ i => self.agregarParedDestructible() })
    
    self.generarComidas()
  }
  
  method configs() {
    keyboard.up().onPressDo({ kike.perderEnergia() })
    keyboard.down().onPressDo({ kike.perderEnergia() })
    keyboard.left().onPressDo({ kike.perderEnergia() })
    keyboard.right().onPressDo({ kike.perderEnergia() })
  }
  
  method agregarParedDestructible() {
    const obstaculoDestructible = new ObstaculoDestructible(
      position = self.posicionAleatoriaVacia()
    )
    listaDeElementos.add(obstaculoDestructible)
    game.addVisual(obstaculoDestructible)
  }
  
  method terminarJuegoMal() {
    self.teclasDeControl()
    self.cargarPantallaDeMuerte()
  }
  
  method terminarJuegoBien() {
    self.teclasDeControl()
    self.cargarPantallaDeVictoria()
  }
  
  method cargarPantallaDeMuerte() {
    juegoEnMarcha = false
    game.clear()
    game.addVisual(gameOver)
    juegoEnMarcha = false
    keyboard.enter().onPressDo(
      { if (not juegoEnMarcha) {
          juegoEnMarcha = true
          game.removeVisual(gameOver)
          listaDeEnemigos.clear()
          kike.recargarVida()
          kike.recargarEnergia()
          kike.position(game.origin())
          self.iniciarJuego()
        } }
    )
  }
  
  method cargarPantallaDeVictoria() {
    juegoEnMarcha = false
    game.clear()
    game.addVisual(victoria)
    keyboard.enter().onPressDo(
      { if (not juegoEnMarcha) {
          juegoEnMarcha = true
          game.removeVisual(victoria)
          listaDeEnemigos.clear()
          kike.recargarVida()
          kike.recargarEnergia()
          kike.position(game.origin())
          self.iniciarJuego()
        } }
    )
  }
  
  method generarComidas() {
    self.aparecerComidaHuesoDeNivel(1)
    self.aparecerComidaLocroDeNivel(2)
    self.aparecerComidaPizza(3)
  }
  
  method agregarObstaculo() {
    const obstaculo = new Obstaculo(position = self.posicionAleatoriaVacia())
    listaDeElementos.add(obstaculo)
    game.addVisual(obstaculo)
  }
  
  method posicionAleatoria() = game.at(
    0.randomUpTo(game.width()),
    0.randomUpTo(game.height())
  )
  
  method posicionAleatoriaVacia() {
    const posiblePosicion = self.posicionAleatoria()
    
    if (game.getObjectsIn(posiblePosicion).isEmpty()) {
      return posiblePosicion
    } else {
      return self.posicionAleatoriaVacia()
    }
  }
  
  method agregarEnemigo(unEnemigo) {
    listaDeEnemigos.add(unEnemigo)
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
    self.aparecerEnemigoPerritoDeNivel(dificultad)
    self.aparecerEnemigoPerroDeNivel(dificultad)
    self.aparecerEnemigoPerroteDeNivel(dificultad)
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