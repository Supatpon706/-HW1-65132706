import 'dart:io';

class Room {
  String _roomNumber;
  String _roomType;
  double _price;
  bool _isBooked;

  Room(this._roomNumber, this._roomType, this._price) : _isBooked = false;

  String get roomNumber => _roomNumber;
  set roomNumber(String roomNumber) => _roomNumber = roomNumber;

  String get roomType => _roomType;
  set roomType(String roomType) => _roomType = roomType;

  double get price => _price;
  set price(double price) => _price = price;

  bool get isBooked => _isBooked;
  set isBooked(bool isBooked) => _isBooked = isBooked;

  void bookRoom() {
    if (!_isBooked) {
      _isBooked = true;
      print('Room $_roomNumber has been booked.');
    } else {
      print('Room $_roomNumber is already booked.');
    }
  }

  void cancelBooking() {
    if (_isBooked) {
      _isBooked = false;
      print('Room $_roomNumber booking has been canceled.');
    } else {
      print('Room $_roomNumber is not booked.');
    }
  }

  void displayRoomInfo() {
    print('Room Number: $_roomNumber, Type: $_roomType, Price: $_price, Booked: $_isBooked');
  }
}

class Guest {
  String _name;
  String _guestId;
  List<Room> _bookedRooms;

  Guest(this._name, this._guestId) : _bookedRooms = [];

  String get name => _name;
  set name(String name) => _name = name;

  String get guestId => _guestId;
  set guestId(String guestId) => _guestId = guestId;

  List<Room> get bookedRooms => _bookedRooms;

  void bookRoom(Room room) {
    if (!room.isBooked) {
      room.bookRoom();
      _bookedRooms.add(room);
      print('Guest $_name has booked room ${room.roomNumber}.');
    } else {
      print('Room ${room.roomNumber} is already booked.');
    }
  }

  void cancelRoom(Room room) {
    if (room.isBooked && _bookedRooms.contains(room)) {
      room.cancelBooking();
      _bookedRooms.remove(room);
      print('Guest $_name has canceled the booking for room ${room.roomNumber}.');
    } else {
      print('Room ${room.roomNumber} is not booked by guest $_name.');
    }
  }

  void displayGuestInfo() {
    print('Guest Name: $_name, Guest ID: $_guestId');
    for (var room in _bookedRooms) {
      room.displayRoomInfo();
    }
  }
}

class Hotel {
  List<Room> _rooms;
  List<Guest> _guests;

  Hotel() 
      : _rooms = [],
        _guests = [];

  List<Room> get rooms => _rooms;
  List<Guest> get guests => _guests;

  void addRoom(Room room) {
    _rooms.add(room);
    print('Room ${room.roomNumber} has been added to the hotel.');
  }

  void removeRoom(String roomNumber) {
    Room? room = getRoom(roomNumber);
    if (room != null) {
      _rooms.remove(room);
      print('Room $roomNumber has been removed from the hotel.');
    } else {
      print('Room $roomNumber not found.');
    }
  }

  void updateRoom(String roomNumber, String newType, double newPrice) {
    Room? room = getRoom(roomNumber);
    if (room != null) {
      room.roomType = newType;
      room.price = newPrice;
      print('Room $roomNumber has been updated.');
    } else {
      print('Room $roomNumber not found.');
    }
  }

  void registerGuest(Guest guest) {
    _guests.add(guest);
    print('Guest ${guest.name} has been registered.');
  }

  void removeGuest(String guestId) {
    Guest? guest = getGuest(guestId);
    if (guest != null) {
      _guests.remove(guest);
      print('Guest $guestId has been removed from the hotel.');
    } else {
      print('Guest $guestId not found.');
    }
  }

  void updateGuest(String guestId, String newName) {
    Guest? guest = getGuest(guestId);
    if (guest != null) {
      guest.name = newName;
      print('Guest $guestId has been updated.');
    } else {
      print('Guest $guestId not found.');
    }
  }

  void bookRoom(String guestId, String roomNumber) {
    Guest? guest = getGuest(guestId);
    Room? room = getRoom(roomNumber);

    if (guest != null && room != null) {
      guest.bookRoom(room);
    }
  }

  void cancelRoom(String guestId, String roomNumber) {
    Guest? guest = getGuest(guestId);
    Room? room = getRoom(roomNumber);

    if (guest != null && room != null) {
      guest.cancelRoom(room);
    }
  }

  Room? getRoom(String roomNumber) {
    for (var room in _rooms) {
      if (room.roomNumber == roomNumber) {
        return room;
      }
    }
    return null;
  }

  Guest? getGuest(String guestId) {
    for (var guest in _guests) {
      if (guest.guestId == guestId) {
        return guest;
      }
    }
    return null;
  }

  void displayHotelInfo() {
    print('Hotel Rooms:');
    for (var room in _rooms) {
      room.displayRoomInfo();
    }
    print('\nHotel Guests:');
    for (var guest in _guests) {
      guest.displayGuestInfo();
    }
  }
}

void main() {
  Hotel hotel = Hotel();

  while (true) {
    print('\nHotel Management System');
    print('1. Add Room');
    print('2. Remove Room');
    print('3. Update Room');
    print('4. Register Guest');
    print('5. Remove Guest');
    print('6. Update Guest');
    print('7. Book Room');
    print('8. Cancel Room');
    print('9. Display Hotel Info');
    print('0. Exit');
    stdout.write('Choose an option: ');
    String? choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        stdout.write('Enter room number: ');
        String? roomNumber = stdin.readLineSync();
        stdout.write('Enter room type (Single, Double, Suite): ');
        String? roomType = stdin.readLineSync();
        stdout.write('Enter room price: ');
        double price = double.parse(stdin.readLineSync()!);
        Room room = Room(roomNumber!, roomType!, price);
        hotel.addRoom(room);
        break;

      case '2':
        stdout.write('Enter room number to remove: ');
        String? roomNumber = stdin.readLineSync();
        hotel.removeRoom(roomNumber!);
        break;

      case '3':
        stdout.write('Enter room number to update: ');
        String? roomNumber = stdin.readLineSync();
        stdout.write('Enter new room type: ');
        String? roomType = stdin.readLineSync();
        stdout.write('Enter new room price: ');
        double price = double.parse(stdin.readLineSync()!);
        hotel.updateRoom(roomNumber!, roomType!, price);
        break;

      case '4':
        stdout.write('Enter guest name: ');
        String? guestName = stdin.readLineSync();
        stdout.write('Enter guest ID: ');
        String? guestId = stdin.readLineSync();
        Guest guest = Guest(guestName!, guestId!);
        hotel.registerGuest(guest);
        break;

      case '5':
        stdout.write('Enter guest ID to remove: ');
        String? guestId = stdin.readLineSync();
        hotel.removeGuest(guestId!);
        break;

      case '6':
        stdout.write('Enter guest ID to update: ');
        String? guestId = stdin.readLineSync();
        stdout.write('Enter new guest name: ');
        String? guestName = stdin.readLineSync();
        hotel.updateGuest(guestId!, guestName!);
        break;

      case '7':
        stdout.write('Enter guest ID: ');
        String? guestId = stdin.readLineSync();
        stdout.write('Enter room number to book: ');
        String? roomNumber = stdin.readLineSync();
        hotel.bookRoom(guestId!, roomNumber!);
        break;

      case '8':
        stdout.write('Enter guest ID: ');
        String? guestId = stdin.readLineSync();
        stdout.write('Enter room number to cancel booking: ');
        String? roomNumber = stdin.readLineSync();
        hotel.cancelRoom(guestId!, roomNumber!);
        break;

      case '9':
        hotel.displayHotelInfo();
        break;

      case '0':
        exit(0);

      default:
        print('Invalid choice. Please try again.');
        break;
    }
  }
}
