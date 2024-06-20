pragma solidity ^0.8.0;

contract PatientRecord {
    struct MedicalRecord {
        string date;          // Дата (зашифрованная)
        string doctor;        // Имя врача (зашифрованное)
        string diagnosis;     // Диагноз (зашифрованный)
        string complaints;    // Жалобы (зашифрованные)
    }

    address public owner;      // Владелец контракта (пациент)
    string public name;        // Имя пациента (зашифрованное)
    MedicalRecord[] public medicalHistory;

    mapping(address => bool) private authorizedDoctors;

    constructor(string memory _name) {
        owner = msg.sender;
        name = _name;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not authorized");
        _;
    }

    modifier onlyAuthorizedDoctor() {
        require(authorizedDoctors[msg.sender] == true, "Not authorized");
        _;
    }

    function addDoctor(address doctor) public onlyOwner {
        authorizedDoctors[doctor] = true;
    }

    function removeDoctor(address doctor) public onlyOwner {
        authorizedDoctors[doctor] = false;
    }

    function addMedicalRecord(
        string memory date,
        string memory doctor,
        string memory diagnosis,
        string memory complaints
    ) public onlyAuthorizedDoctor {
        MedicalRecord memory newRecord = MedicalRecord(date, doctor, diagnosis, complaints);
        medicalHistory.push(newRecord);
    }

    function getMedicalHistory() public view onlyAuthorizedDoctor returns (MedicalRecord[] memory) {
        return medicalHistory;
    }
}

