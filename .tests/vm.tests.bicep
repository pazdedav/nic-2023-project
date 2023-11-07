module vm '../vm.bicep' = {
  name: 'vm01'
  params: {
    location: 'westus'
    vmName: 'vm01'
    vmSKU: 'Standard_G1'
  }
}
