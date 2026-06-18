class Obstaculo {
  const position
  
  method position() = position
  
  method image() = "pared.png"
  
  method teCruzasteCon(personaje, elemento) {
    personaje.retroceder()
  }
}