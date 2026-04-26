// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CertificateVerifier {
    
    struct Certificate {
        string studentName;
        string courseName;
        string issueDate;
        bool exists;
    }

    mapping(bytes32 => Certificate) private certificates;
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    // Issue a certificate
    function issueCertificate(
        string memory _id,
        string memory _studentName,
        string memory _courseName,
        string memory _issueDate
    ) public {
        bytes32 hash = keccak256(abi.encodePacked(_id));
        certificates[hash] = Certificate(_studentName, _courseName, _issueDate, true);
    }

    // Verify a certificate
    function verifyCertificate(string memory _id) public view returns (
        bool valid,
        string memory studentName,
        string memory courseName,
        string memory issueDate
    ) {
        bytes32 hash = keccak256(abi.encodePacked(_id));
        Certificate memory cert = certificates[hash];
        return (cert.exists, cert.studentName, cert.courseName, cert.issueDate);
    }
}