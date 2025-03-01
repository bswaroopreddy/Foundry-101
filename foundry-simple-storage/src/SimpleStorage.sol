// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24; // this is the solidity version

contract SimpleStorage {
    // Basic Types: boolean, uint, int, address, bytes
    bool hasFavoriteNumber = false;
    int256 favoriteNumberInt = -88;
    string favoriteNumberInText = "88";
    address myAddress = 0xb16Cba5320534C57d7B70681f6be69FCcaB5EEd9;
    bytes8 favoriteBytes32 = "swaroop"; //0x12323232

    // favoriteNumberUint is initialized to 0 if no value given
    uint256 myfavoriteNumberUint; //0
    uint256 public myfavoriteNumber;

    uint256[] listOfFavoriteNumbers;

    struct Person {
        uint256 favoriteNumber;
        string name; // []
    }

    // Person public pat = Person(1, "Pat");
    // Person public michael = Person(2, "Michael");
    // Person public mitchell = Person(5, "Mitchell");

    Person[] public listOfPeople;

    function store(uint256 _myfavoriteNumber) public virtual {
        myfavoriteNumber = _myfavoriteNumber;
        myfavoriteNumber = myfavoriteNumber + 1;
    }

    // 0xd9145CCE52D386f254917e481eB44e9943F39138

    // view - Read state from the Blockchain and dis allow updating state
    // pure - Read constants
    function retrieve() public view returns (uint256) {
        return myfavoriteNumber;
    }

    function retrieveConst() public pure returns (uint256) {
        return 11;
    }

    // storage variable
    // state variables are storage variables which are permanant and modifiable.
    // function arguments cann't be defined with storage as they are temporory,
    // arguments need to be defined either as memory or calldata

    // memory variable
    // data location (i.e. memory) can be only be specified for array, struct or mapping types, but not required for int, uint types.
    function addPerson(string memory _name, uint256 _favoriteNumber) public {
        //Person memory newPerson = Person(_favoriteNumber, _name);
        _name = "swaroop"; // memory variable is a temporory and modifiable
        listOfPeople.push(Person(_favoriteNumber, _name));
        //listOfPeople.push(newPerson);
    }

    // calldata variable
    function addPersonWithCalldata(string calldata _name, uint256 _favoriteNumber) public {
        //Person memory newPerson = Person(_favoriteNumber, _name);
        // _name = "swaroop";  // calldata variable is a temporory and cannot be modifiable
        listOfPeople.push(Person(_favoriteNumber, _name));
        //listOfPeople.push(newPerson);
    }
}

contract SimpleStorage1 {}

contract SimpleStorage2 {}
