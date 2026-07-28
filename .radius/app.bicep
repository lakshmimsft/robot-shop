extension radius

param environment string

param registryUsername string

@secure()
param registryPassword string

param image string = ''

resource robotShopApp 'Radius.Core/applications@2025-08-01-preview' = {
  name: 'robot-shop'
  properties: {
    environment: environment
  }
}

resource registryCreds 'Radius.Security/secrets@2025-08-01-preview' = {
  name: 'radius-ghcr-registry-creds'
  properties: {
    environment: environment
    application: robotShopApp.id
    data: {
      username: {
        value: registryUsername
      }
      password: {
        value: registryPassword
      }
    }
  }
}

resource mongodbImage 'Radius.Compute/containerImages@2025-08-01-preview' = {
  name: 'mongodb-image'
  properties: {
    environment: environment
    application: robotShopApp.id
    codeReference: 'mongo/Dockerfile'
    build: {
      source: 'git::https://github.com/lakshmimsft/robot-shop.git//mongo?ref=804eb8a0d261bdb5cea59897ea542e7f667442d1'
      platforms: [
        'linux/amd64'
      ]
    }
  }
  dependsOn: [
    registryCreds
  ]
}

resource mysqlImage 'Radius.Compute/containerImages@2025-08-01-preview' = {
  name: 'mysql-image'
  properties: {
    environment: environment
    application: robotShopApp.id
    codeReference: 'mysql/Dockerfile'
    build: {
      source: 'git::https://github.com/lakshmimsft/robot-shop.git//mysql?ref=804eb8a0d261bdb5cea59897ea542e7f667442d1'
      platforms: [
        'linux/amd64'
      ]
    }
  }
  dependsOn: [
    registryCreds
  ]
}

resource catalogueImage 'Radius.Compute/containerImages@2025-08-01-preview' = {
  name: 'catalogue-image'
  properties: {
    environment: environment
    application: robotShopApp.id
    codeReference: 'catalogue/Dockerfile'
    build: {
      source: 'git::https://github.com/lakshmimsft/robot-shop.git//catalogue?ref=804eb8a0d261bdb5cea59897ea542e7f667442d1'
      platforms: [
        'linux/amd64'
      ]
    }
  }
  dependsOn: [
    registryCreds
  ]
}

resource userImage 'Radius.Compute/containerImages@2025-08-01-preview' = {
  name: 'user-image'
  properties: {
    environment: environment
    application: robotShopApp.id
    codeReference: 'user/Dockerfile'
    build: {
      source: 'git::https://github.com/lakshmimsft/robot-shop.git//user?ref=804eb8a0d261bdb5cea59897ea542e7f667442d1'
      platforms: [
        'linux/amd64'
      ]
    }
  }
  dependsOn: [
    registryCreds
  ]
}

resource cartImage 'Radius.Compute/containerImages@2025-08-01-preview' = {
  name: 'cart-image'
  properties: {
    environment: environment
    application: robotShopApp.id
    codeReference: 'cart/Dockerfile'
    build: {
      source: 'git::https://github.com/lakshmimsft/robot-shop.git//cart?ref=804eb8a0d261bdb5cea59897ea542e7f667442d1'
      platforms: [
        'linux/amd64'
      ]
    }
  }
  dependsOn: [
    registryCreds
  ]
}

resource shippingImage 'Radius.Compute/containerImages@2025-08-01-preview' = {
  name: 'shipping-image'
  properties: {
    environment: environment
    application: robotShopApp.id
    codeReference: 'shipping/Dockerfile'
    build: {
      source: 'git::https://github.com/lakshmimsft/robot-shop.git//shipping?ref=804eb8a0d261bdb5cea59897ea542e7f667442d1'
      platforms: [
        'linux/amd64'
      ]
    }
  }
  dependsOn: [
    registryCreds
  ]
}

resource ratingsImage 'Radius.Compute/containerImages@2025-08-01-preview' = {
  name: 'ratings-image'
  properties: {
    environment: environment
    application: robotShopApp.id
    codeReference: 'ratings/Dockerfile'
    build: {
      source: 'git::https://github.com/lakshmimsft/robot-shop.git//ratings?ref=804eb8a0d261bdb5cea59897ea542e7f667442d1'
      platforms: [
        'linux/amd64'
      ]
    }
  }
  dependsOn: [
    registryCreds
  ]
}

resource paymentImage 'Radius.Compute/containerImages@2025-08-01-preview' = {
  name: 'payment-image'
  properties: {
    environment: environment
    application: robotShopApp.id
    codeReference: 'payment/Dockerfile'
    build: {
      source: 'git::https://github.com/lakshmimsft/robot-shop.git//payment?ref=804eb8a0d261bdb5cea59897ea542e7f667442d1'
      platforms: [
        'linux/amd64'
      ]
    }
  }
  dependsOn: [
    registryCreds
  ]
}

resource dispatchImage 'Radius.Compute/containerImages@2025-08-01-preview' = {
  name: 'dispatch-image'
  properties: {
    environment: environment
    application: robotShopApp.id
    codeReference: 'dispatch/Dockerfile'
    build: {
      source: 'git::https://github.com/lakshmimsft/robot-shop.git//dispatch?ref=804eb8a0d261bdb5cea59897ea542e7f667442d1'
      platforms: [
        'linux/amd64'
      ]
    }
  }
  dependsOn: [
    registryCreds
  ]
}

resource webImage 'Radius.Compute/containerImages@2025-08-01-preview' = {
  name: 'web-image'
  properties: {
    environment: environment
    application: robotShopApp.id
    codeReference: 'web/Dockerfile'
    build: {
      source: 'git::https://github.com/lakshmimsft/robot-shop.git//web?ref=804eb8a0d261bdb5cea59897ea542e7f667442d1'
      platforms: [
        'linux/amd64'
      ]
    }
  }
  dependsOn: [
    registryCreds
  ]
}

resource mongodbContainer 'Radius.Compute/containers@2025-08-01-preview' = {
  name: 'mongodb'
  properties: {
    environment: environment
    application: robotShopApp.id
    codeReference: 'mongo/Dockerfile'
    containers: {
      mongodb: {
        image: mongodbImage.properties.imageReference
        ports: {
          mongo: {
            containerPort: 27017
          }
        }
      }
    }
  }
}

resource mysqlContainer 'Radius.Compute/containers@2025-08-01-preview' = {
  name: 'mysql'
  properties: {
    environment: environment
    application: robotShopApp.id
    codeReference: 'mysql/Dockerfile'
    containers: {
      mysql: {
        image: mysqlImage.properties.imageReference
        ports: {
          mysql: {
            containerPort: 3306
          }
        }
      }
    }
  }
}

resource redisContainer 'Radius.Compute/containers@2025-08-01-preview' = {
  name: 'redis'
  properties: {
    environment: environment
    application: robotShopApp.id
    codeReference: 'cart/server.js#L390'
    containers: {
      redis: {
        image: 'redis:6.2-alpine'
        ports: {
          redis: {
            containerPort: 6379
          }
        }
      }
    }
  }
}

resource rabbitmqContainer 'Radius.Compute/containers@2025-08-01-preview' = {
  name: 'rabbitmq'
  properties: {
    environment: environment
    application: robotShopApp.id
    codeReference: 'payment/rabbitmq.py#L22'
    containers: {
      rabbitmq: {
        image: 'rabbitmq:3.8-management-alpine'
        ports: {
          amqp: {
            containerPort: 5672
          }
          management: {
            containerPort: 15672
          }
        }
      }
    }
  }
}

resource catalogueContainer 'Radius.Compute/containers@2025-08-01-preview' = {
  name: 'catalogue'
  properties: {
    environment: environment
    application: robotShopApp.id
    codeReference: 'catalogue/server.js#L157'
    containers: {
      catalogue: {
        image: catalogueImage.properties.imageReference
        ports: {
          web: {
            containerPort: 8080
          }
        }
        env: {
          MONGO_URL: {
            value: 'mongodb://mongodb-mongodb:27017/catalogue'
          }
          CATALOGUE_SERVER_PORT: {
            value: '8080'
          }
        }
      }
    }
  }
  dependsOn: [
    mongodbContainer
  ]
}

resource userContainer 'Radius.Compute/containers@2025-08-01-preview' = {
  name: 'user'
  properties: {
    environment: environment
    application: robotShopApp.id
    codeReference: 'user/server.js#L272'
    containers: {
      user: {
        image: userImage.properties.imageReference
        ports: {
          web: {
            containerPort: 8080
          }
        }
        env: {
          MONGO_URL: {
            value: 'mongodb://mongodb-mongodb:27017/users'
          }
          REDIS_HOST: {
            value: 'redis-redis'
          }
          USER_SERVER_PORT: {
            value: '8080'
          }
        }
      }
    }
  }
  dependsOn: [
    mongodbContainer
    redisContainer
  ]
}

resource cartContainer 'Radius.Compute/containers@2025-08-01-preview' = {
  name: 'cart'
  properties: {
    environment: environment
    application: robotShopApp.id
    codeReference: 'cart/server.js#L390'
    containers: {
      cart: {
        image: cartImage.properties.imageReference
        ports: {
          web: {
            containerPort: 8080
          }
        }
        env: {
          REDIS_HOST: {
            value: 'redis-redis'
          }
          CATALOGUE_HOST: {
            value: 'catalogue-catalogue'
          }
          CART_SERVER_PORT: {
            value: '8080'
          }
        }
      }
    }
  }
  dependsOn: [
    catalogueContainer
    redisContainer
  ]
}

resource shippingContainer 'Radius.Compute/containers@2025-08-01-preview' = {
  name: 'shipping'
  properties: {
    environment: environment
    application: robotShopApp.id
    codeReference: 'shipping/src/main/java/com/instana/robotshop/shipping/JpaConfig.java#L16'
    containers: {
      shipping: {
        image: shippingImage.properties.imageReference
        ports: {
          web: {
            containerPort: 8080
          }
        }
        env: {
          DB_HOST: {
            value: 'mysql-mysql'
          }
          CART_ENDPOINT: {
            value: 'cart-cart:8080'
          }
        }
      }
    }
  }
  dependsOn: [
    mysqlContainer
    cartContainer
  ]
}

resource ratingsContainer 'Radius.Compute/containers@2025-08-01-preview' = {
  name: 'ratings'
  properties: {
    environment: environment
    application: robotShopApp.id
    codeReference: 'ratings/html/src/Kernel.php#L77'
    containers: {
      ratings: {
        image: ratingsImage.properties.imageReference
        ports: {
          web: {
            containerPort: 80
          }
        }
        env: {
          APP_ENV: {
            value: 'prod'
          }
          PDO_URL: {
            value: 'mysql:host=mysql-mysql;dbname=ratings;charset=utf8mb4'
          }
          CATALOGUE_URL: {
            value: 'http://catalogue-catalogue:8080'
          }
        }
      }
    }
  }
  dependsOn: [
    mysqlContainer
    catalogueContainer
  ]
}

resource paymentContainer 'Radius.Compute/containers@2025-08-01-preview' = {
  name: 'payment'
  properties: {
    environment: environment
    application: robotShopApp.id
    codeReference: 'payment/payment.py#L24'
    containers: {
      payment: {
        image: paymentImage.properties.imageReference
        ports: {
          web: {
            containerPort: 8080
          }
        }
        env: {
          AMQP_HOST: {
            value: 'rabbitmq-rabbitmq'
          }
          CART_HOST: {
            value: 'cart-cart'
          }
          USER_HOST: {
            value: 'user-user'
          }
          SHOP_PAYMENT_PORT: {
            value: '8080'
          }
        }
      }
    }
  }
  dependsOn: [
    rabbitmqContainer
    cartContainer
    userContainer
  ]
}

resource dispatchContainer 'Radius.Compute/containers@2025-08-01-preview' = {
  name: 'dispatch'
  properties: {
    environment: environment
    application: robotShopApp.id
    codeReference: 'dispatch/main.go#L179'
    containers: {
      dispatch: {
        image: dispatchImage.properties.imageReference
        env: {
          AMQP_HOST: {
            value: 'rabbitmq-rabbitmq'
          }
        }
      }
    }
  }
  dependsOn: [
    rabbitmqContainer
  ]
}

resource webContainer 'Radius.Compute/containers@2025-08-01-preview' = {
  name: 'web'
  properties: {
    environment: environment
    application: robotShopApp.id
    codeReference: 'web/Dockerfile'
    containers: {
      web: {
        image: webImage.properties.imageReference
        ports: {
          web: {
            containerPort: 8080
          }
        }
        env: {
          CATALOGUE_HOST: {
            value: 'catalogue-catalogue'
          }
          USER_HOST: {
            value: 'user-user'
          }
          CART_HOST: {
            value: 'cart-cart'
          }
          SHIPPING_HOST: {
            value: 'shipping-shipping'
          }
          PAYMENT_HOST: {
            value: 'payment-payment'
          }
          RATINGS_HOST: {
            value: 'ratings-ratings'
          }
        }
      }
    }
  }
  dependsOn: [
    catalogueContainer
    userContainer
    cartContainer
    shippingContainer
    paymentContainer
    ratingsContainer
  ]
}

resource webRoute 'Radius.Compute/routes@2025-08-01-preview' = {
  name: 'web-route'
  properties: {
    environment: environment
    application: robotShopApp.id
    codeReference: 'K8s/helm/templates/web-service.yaml'
    rules: [
      {
        matches: [
          {
            httpPath: '/'
          }
        ]
        destinationContainer: {
          resourceId: webContainer.id
          containerName: 'web'
          containerPort: 8080
        }
      }
    ]
  }
}
