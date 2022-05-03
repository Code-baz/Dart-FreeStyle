/**
 * created by Nasser Amini (Nas) May 2022
 *  --- CODE BAZ --- github.com/Code-baz
 * (codebaz40@gmail.com)
 */


/// there are [x] number of motorbikes which has a full tank of fuel
/// you can travel a distance of [d] with a fuel tank bike
/// how far can you go? (hint: you can go to a distance and come back to another bike and you can full a tank using other bike's tank)

// number of bikes
num x = 50; //for example

// distance each bike can travel using a full tank
num d = 100; // in kilometers

void main() {

    final simulation = Simulation(x.toInt(),d,10);
    simulation.run();

}



class Simulation {
  late List<Bike> bikes;
  late num eachTimeDistance;
  late num fullTankDistance;
  late num _fuelForOneStep;

  num totalDistance = 0.0;
  Simulation(int numberOfBikes,num fullTankDistance,num eachTimeDistance) {
    this.fullTankDistance = fullTankDistance;
    this.eachTimeDistance = eachTimeDistance;
    _fuelForOneStep=eachTimeDistance / fullTankDistance;
    bikes = List.generate(
        numberOfBikes, (index) => Bike(_fuelForOneStep));
  }


  void goOneStep() {
    for(int i=0;i<bikes.length;i++){
      bikes.elementAt(i).goAnotherStep();
     }
    totalDistance +=eachTimeDistance;
  }

  void run() {
    while(_divideFuel()){
      goOneStep();
    }
    print('bikes:$x ,total distance: $totalDistance');
  }

  bool _divideFuel() {
    num totalFuel = 0.0;
    for(int i = 0;i<bikes.length;i++){
      totalFuel +=bikes.elementAt(i).fuel;
    }
    bikes = List.generate(totalFuel.floor()+1, (index) => Bike(_fuelForOneStep));
    bikes.last.fuel = totalFuel - totalFuel.floor();
    return totalFuel>=_fuelForOneStep;
  }

}

class Bike {
  num fuel = 1.0;
  bool isFull = true;
  bool canGoAnotherStep = true;
  bool isEmpty = false;
  num fuelNeededForAnotherStep;

  Bike(this.fuelNeededForAnotherStep);


  void goAnotherStep(){
    if(fuel>0) {
      fuel -= fuelNeededForAnotherStep;
      isFull = false;
      canGoAnotherStep = fuel >= fuelNeededForAnotherStep;
      isEmpty = fuel == 0.0;
    }
  }

  void fullMe(num fuelAmount) {
    if (!isFull) {
      fuel += fuelAmount;
      isFull = fuel == 1;
      canGoAnotherStep = fuel>=fuelNeededForAnotherStep;
    }
  }

  void iGiveYouFuel(num fuelAmount) {
    fuel -=fuelAmount;
    isFull = false;
    canGoAnotherStep = fuel>fuelNeededForAnotherStep;

  }

  num takeAllMyFuel(){
    isEmpty = true;
    return fuel;
  }


}