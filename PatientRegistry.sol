pragma solidity ^0.8.0;

contract PatientRegistry {
    mapping(address => address) public patientContracts;
    address[] public allPatients;

    function createPatientContract(string memory _name) public {
        require(patientContracts[msg.sender] == address(0), "Patient contract already exists");

        PatientRecord newPatientContract = new PatientRecord(_name);
        patientContracts[msg.sender] = address(newPatientContract);
        allPatients.push(msg.sender);
    }

    function getPatientContract(address patientAddress) public view returns (address) {
        return patientContracts[patientAddress];
    }

    function getAllPatients() public view returns (address[] memory) {
        return allPatients;
    }
}
