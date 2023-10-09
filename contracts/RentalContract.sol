// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;
contract RentalContract {
    struct Property {
        string propertyType; // 'house' or 'shop'
        string propertyAddress;
        address owner;
    }

    struct Lease {
        string tenantInfo;
        uint256 startDate;
        uint256 endDate;
    }

    struct Issue {
        string description;
        bool resolved;
    }

    mapping(address => Property) public properties;
    mapping(address => Lease) public leases;
    mapping(address => Issue[]) public issues;

    function addProperty(string memory _propertyType, string memory _propertyAddress) public {
        properties[msg.sender] = Property(_propertyType, _propertyAddress, msg.sender);
    }

    function leaseProperty(address _propertyAddress, string memory _tenantInfo, uint256 _startDate, uint256 _endDate) public {
        require(properties[_propertyAddress].owner == msg.sender, "Only the owner can lease the property");
        leases[_propertyAddress] = Lease(_tenantInfo, _startDate, _endDate);
    }

    function terminateLease(address _propertyAddress) public {
        require(properties[_propertyAddress].owner == msg.sender, "Only the owner can terminate the lease");
        delete leases[_propertyAddress];
    }

    function reportIssue(address _propertyAddress, string memory _description) public {
        issues[_propertyAddress].push(Issue(_description, false));
    }

    function resolveIssue(address _propertyAddress, uint256 _issueIndex) public {
        require(properties[_propertyAddress].owner == msg.sender, "Only the owner can resolve issues");
        issues[_propertyAddress][_issueIndex].resolved = true;
    }
}