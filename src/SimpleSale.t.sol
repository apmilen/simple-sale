pragma solidity ^0.4.17;

import "ds-test/test.sol";

import "./SimpleSale.sol";

contract SimpleSaleTest is DSTest {
    SimpleSale sale;

    function setUp() {
        sale = new SimpleSale();
    }

    function testFail_basic_sanity() {
        assertTrue(false);
    }

    function test_basic_sanity() {
        assertTrue(true);
    }
}
