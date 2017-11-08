pragma solidity ^0.4.17;

import "ds-token/token.sol";
import "ds-math/math.sol";

contract SimpleSale is DSMath {

    DSToken public token;

    uint public total;

    uint public endTime;

    address public multisig;

    uint public rate; // Token per ETH

    function SimpleSale(
        bytes32 symbol, 
        uint total_, 
        uint endTime_,
        uint rate_,
        address multisig_) public {

        token = new DSToken(symbol);

        total = total_;
        
        endTime = endTime_;

        multisig = multisig_;

        rate = rate_;

        token.mint(total);
    }

    function() public payable {

        require(now < endTime);

        uint requested = wmul(msg.value, rate);

        token.push(msg.sender, requested);

        multisig.transfer(msg.value);        
    }

    function finalize() public {
        require(now >= endTime);

        // transfer undistributed Token
        token.push(multisig, token.balanceOf(this));

        // owner -> multisig
        token.setOwner(multisig);
    }
}