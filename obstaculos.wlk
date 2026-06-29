class Obstaculo {
  const position
  
  method position() = position
  
  method image() = "pared.png"
  
  method teCruzasteCon(personaje, elemento) {
    personaje.retroceder()
    game.say(self, "No se puede pasar por acá")
  }
}

class ObstaculoDestructible inherits Obstaculo {
  override method image() = "pared2.png"
  
  override method teCruzasteCon(personaje, elemento) {
    personaje.romperPared(self)
    game.sound("paredSound.mp3").play()
  }
}