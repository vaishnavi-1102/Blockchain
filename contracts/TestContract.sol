// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract TestContract {
    address public admin;

    event DrugAdded(uint indexed drugId, string name, uint quantity, uint price);
    event TracingInfoAdded(uint indexed drugId, string tracingType, string details, string date);

    constructor() {
        admin = msg.sender;
    }

    struct Drug {
        string name;
        uint quantity;
        uint price;
        string description;
        string lastUpdateDate;
        string currentTracingDetails;
    }

    struct Tracing {
        string tracingType;
        string tracingDetails;
        string date;
    }

    Drug[] public drugs;
    mapping(uint => Tracing[]) public drugTracings;
    mapping(address => uint) public lastActionTime;
    uint public constant ACTION_DELAY = 30 seconds;

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can perform this action");
        _;
    }

    modifier rateLimit() {
        require(block.timestamp > lastActionTime[msg.sender] + ACTION_DELAY, "Action too frequent");
        _;
        lastActionTime[msg.sender] = block.timestamp;
    }

    function drugExists(uint drugId) public view returns (bool) {
        return drugId < drugs.length;
    }

    function addDrug(
        string memory name, 
        uint quantity, 
        uint price, 
        string memory description
    ) public onlyAdmin rateLimit {
        require(bytes(name).length > 0, "Name cannot be empty");
        require(quantity > 0, "Quantity must be positive");
        require(price > 0, "Price must be positive");
        
        drugs.push(Drug(name, quantity, price, description, "", ""));
        emit DrugAdded(drugs.length - 1, name, quantity, price);
    }

    function updateDrug(
        uint drugId,
        uint newQuantity,
        uint newPrice,
        string memory newDescription
    ) public onlyAdmin rateLimit {
        require(drugExists(drugId), "Drug does not exist");
        require(newQuantity > 0, "Quantity must be positive");
        require(newPrice > 0, "Price must be positive");
        
        Drug storage drug = drugs[drugId];
        drug.quantity = newQuantity;
        drug.price = newPrice;
        drug.description = newDescription;
    }

    function getDrugCount() public view returns (uint) {
        return drugs.length;
    }

    function getDrug(uint index) public view returns (
        string memory name,
        uint quantity,
        uint price,
        string memory description,
        string memory lastUpdateDate,
        string memory currentTracingDetails
    ) {
        Drug storage drug = drugs[index];
        return (
            drug.name,
            drug.quantity,
            drug.price,
            drug.description,
            drug.lastUpdateDate,
            drug.currentTracingDetails
        );
    }

    function addTracingInfo(
        uint drugId,
        string memory tracingType,
        string memory tracingDetails,
        string memory date
    ) public onlyAdmin rateLimit {
        require(drugExists(drugId), "Invalid Drug ID");
        require(bytes(tracingType).length > 0, "Tracing type cannot be empty");
        require(bytes(tracingDetails).length > 0, "Details cannot be empty");
        require(bytes(date).length > 0, "Date cannot be empty");

        drugTracings[drugId].push(Tracing(tracingType, tracingDetails, date));
        drugs[drugId].lastUpdateDate = date;
        drugs[drugId].currentTracingDetails = tracingDetails;
        emit TracingInfoAdded(drugId, tracingType, tracingDetails, date);
    }

    function getTracingInfo(uint drugId) public view returns (
        string[] memory types,
        string[] memory details,
        string[] memory dates
    ) {
        require(drugExists(drugId), "Drug does not exist");
        
        uint count = drugTracings[drugId].length;
        types = new string[](count);
        details = new string[](count);
        dates = new string[](count);

        for (uint i = 0; i < count; i++) {
            Tracing storage t = drugTracings[drugId][i];
            types[i] = t.tracingType;
            details[i] = t.tracingDetails;
            dates[i] = t.date;
        }

        return (types, details, dates);
    }

    function getAdmin() public view returns (address) {
        return admin;
    }
}