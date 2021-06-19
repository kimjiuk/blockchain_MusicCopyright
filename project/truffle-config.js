module.exports = {
  networks: {
    development: {
      host: "127.0.0.1",
      port:7545,
      network_id: "*"
    }  
  },

  mocha: {
    // timeout: 100000
  },

  // Configure your compilers
  compilers: {
    solc: {
      version: "0.4.24",
    }
  },

  
  db: {
    enabled: false
  }
};
