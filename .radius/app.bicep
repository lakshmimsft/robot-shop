extension radius

param environment string

@description('Password/token for the OCI registry the containerImages recipe pushes to (a GitHub token with write:packages for ghcr.io).')
@secure()
param registryPassword string

@description('Username for the OCI registry the containerImages recipe pushes to (the GitHub actor for ghcr.io).')
@secure()
param registryUsername string

resource robotShopApp 'Radius.Core/applications@2025-08-01-preview' = {
  name: 'robot-shop'
  properties: {
    environment: environment
  }
}

resource cartImage 'Radius.Compute/containerImages@2025-08-01-preview' = {
  name: 'cart-image'
  properties: {
    environment: environment
    application: robotShopApp.id
    codeReference: 'cart/Dockerfile'
    tag: '11480ec'
    build: {
      source: 'git::https://github.com/lakshmimsft/robot-shop.git//cart?ref=11480ec6197e6e72fb2343d2cbe78fd9ae32a1f6'
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
    tag: '11480ec'
    build: {
      source: 'git::https://github.com/lakshmimsft/robot-shop.git//catalogue?ref=11480ec6197e6e72fb2343d2cbe78fd9ae32a1f6'
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
    tag: '11480ec'
    build: {
      source: 'git::https://github.com/lakshmimsft/robot-shop.git//dispatch?ref=11480ec6197e6e72fb2343d2cbe78fd9ae32a1f6'
      platforms: [
        'linux/amd64'
      ]
    }
  }
  dependsOn: [
    registryCreds
  ]
}

resource mongodbImage 'Radius.Compute/containerImages@2025-08-01-preview' = {
  name: 'mongodb-image'
  properties: {
    environment: environment
    application: robotShopApp.id
    codeReference: 'mongo/Dockerfile'
    tag: '11480ec'
    build: {
      source: 'git::https://github.com/lakshmimsft/robot-shop.git//mongo?ref=11480ec6197e6e72fb2343d2cbe78fd9ae32a1f6'
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
    tag: '11480ec'
    build: {
      source: 'git::https://github.com/lakshmimsft/robot-shop.git//mysql?ref=11480ec6197e6e72fb2343d2cbe78fd9ae32a1f6'
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
    tag: '11480ec'
    build: {
      source: 'git::https://github.com/lakshmimsft/robot-shop.git//payment?ref=11480ec6197e6e72fb2343d2cbe78fd9ae32a1f6'
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
    tag: '11480ec'
    build: {
      source: 'git::https://github.com/lakshmimsft/robot-shop.git//ratings?ref=11480ec6197e6e72fb2343d2cbe78fd9ae32a1f6'
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
    tag: '11480ec'
    build: {
      source: 'git::https://github.com/lakshmimsft/robot-shop.git//shipping?ref=11480ec6197e6e72fb2343d2cbe78fd9ae32a1f6'
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
    tag: '11480ec'
    build: {
      source: 'git::https://github.com/lakshmimsft/robot-shop.git//user?ref=11480ec6197e6e72fb2343d2cbe78fd9ae32a1f6'
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
    tag: '11480ec'
    build: {
      source: 'git::https://github.com/lakshmimsft/robot-shop.git//web?ref=11480ec6197e6e72fb2343d2cbe78fd9ae32a1f6'
      platforms: [
        'linux/amd64'
      ]
    }
  }
  dependsOn: [
    registryCreds
  ]
}

resource cartContainer 'Radius.Compute/containers@2025-08-01-preview' = {
  name: 'cart'
  properties: {
    environment: environment
    application: robotShopApp.id
    codeReference: 'cart/server.js#L404'
    containers: {
      cart: {
        image: cartImage.properties.imageReference
        env: {
          CART_SERVER_PORT: {
            value: '8080'
          }
          CATALOGUE_HOST: {
            value: catalogueContainer.properties.hosts.catalogue
          }
          REDIS_HOST: {
            value: redisContainer.properties.hosts.redis
          }
        }
        ports: {
          web: {
            containerPort: 8080
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
    codeReference: 'catalogue/server.js#L185'
    containers: {
      catalogue: {
        image: catalogueImage.properties.imageReference
        env: {
          CATALOGUE_SERVER_PORT: {
            value: '8080'
          }
          MONGO_URL: {
            value: 'mongodb://${mongodbContainer.properties.hosts.mongodb}:27017/catalogue'
          }
        }
        ports: {
          web: {
            containerPort: 8080
          }
        }
      }
    }
  }
}

resource dispatchContainer 'Radius.Compute/containers@2025-08-01-preview' = {
  name: 'dispatch'
  properties: {
    environment: environment
    application: robotShopApp.id
    codeReference: 'dispatch/main.go#L167'
    containers: {
      dispatch: {
        image: dispatchImage.properties.imageReference
        env: {
          AMQP_HOST: {
            value: rabbitmqContainer.properties.hosts.rabbitmq
          }
        }
      }
    }
  }
}

resource mongodbContainer 'Radius.Compute/containers@2025-08-01-preview' = {
  name: 'mongodb'
  properties: {
    environment: environment
    application: robotShopApp.id
    codeReference: 'mongo/catalogue.js#L1'
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
    codeReference: 'mysql/scripts/20-ratings.sql#L1'
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

resource paymentContainer 'Radius.Compute/containers@2025-08-01-preview' = {
  name: 'payment'
  properties: {
    environment: environment
    application: robotShopApp.id
    codeReference: 'payment/payment.py#L155'
    containers: {
      payment: {
        image: paymentImage.properties.imageReference
        env: {
          AMQP_HOST: {
            value: rabbitmqContainer.properties.hosts.rabbitmq
          }
          CART_HOST: {
            value: cartContainer.properties.hosts.cart
          }
          SHOP_PAYMENT_PORT: {
            value: '8080'
          }
          USER_HOST: {
            value: userContainer.properties.hosts.user
          }
        }
        ports: {
          web: {
            containerPort: 8080
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
    codeReference: '.radius/app.bicep#L357'
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

resource ratingsContainer 'Radius.Compute/containers@2025-08-01-preview' = {
  name: 'ratings'
  properties: {
    environment: environment
    application: robotShopApp.id
    codeReference: 'ratings/html/index.php#L10'
    containers: {
      ratings: {
        image: ratingsImage.properties.imageReference
        env: {
          APP_ENV: {
            value: 'prod'
          }
          CATALOGUE_URL: {
            value: 'http://${catalogueContainer.properties.hosts.catalogue}:8080'
          }
          PDO_URL: {
            value: 'mysql:host=${mysqlContainer.properties.hosts.mysql};dbname=ratings;charset=utf8mb4'
          }
        }
        ports: {
          web: {
            containerPort: 80
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
    codeReference: '.radius/app.bicep#L409'
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

resource shippingContainer 'Radius.Compute/containers@2025-08-01-preview' = {
  name: 'shipping'
  properties: {
    environment: environment
    application: robotShopApp.id
    codeReference: 'shipping/src/main/java/com/instana/robotshop/shipping/ShippingServiceApplication.java#L37'
    containers: {
      shipping: {
        image: shippingImage.properties.imageReference
        env: {
          CART_ENDPOINT: {
            value: '${cartContainer.properties.hosts.cart}:8080'
          }
          DB_HOST: {
            value: mysqlContainer.properties.hosts.mysql
          }
        }
        ports: {
          web: {
            containerPort: 8080
          }
        }
      }
    }
  }
}

resource userContainer 'Radius.Compute/containers@2025-08-01-preview' = {
  name: 'user'
  properties: {
    environment: environment
    application: robotShopApp.id
    codeReference: 'user/server.js#L300'
    containers: {
      user: {
        image: userImage.properties.imageReference
        env: {
          MONGO_URL: {
            value: 'mongodb://${mongodbContainer.properties.hosts.mongodb}:27017/users'
          }
          REDIS_HOST: {
            value: redisContainer.properties.hosts.redis
          }
          USER_SERVER_PORT: {
            value: '8080'
          }
        }
        ports: {
          web: {
            containerPort: 8080
          }
        }
      }
    }
  }
}

resource webContainer 'Radius.Compute/containers@2025-08-01-preview' = {
  name: 'web'
  properties: {
    environment: environment
    application: robotShopApp.id
    codeReference: 'web/entrypoint.sh#L1'
    containers: {
      web: {
        image: webImage.properties.imageReference
        env: {
          CART_HOST: {
            value: cartContainer.properties.hosts.cart
          }
          CATALOGUE_HOST: {
            value: catalogueContainer.properties.hosts.catalogue
          }
          PAYMENT_HOST: {
            value: paymentContainer.properties.hosts.payment
          }
          RATINGS_HOST: {
            value: ratingsContainer.properties.hosts.ratings
          }
          SHIPPING_HOST: {
            value: shippingContainer.properties.hosts.shipping
          }
          USER_HOST: {
            value: userContainer.properties.hosts.user
          }
        }
        ports: {
          web: {
            containerPort: 8080
          }
        }
      }
    }
  }
}

resource webRoute 'Radius.Compute/routes@2025-08-01-preview' = {
  name: 'web-route'
  properties: {
    environment: environment
    application: robotShopApp.id
    codeReference: 'K8s/helm/templates/web-service.yaml#L14'
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

resource registryCreds 'Radius.Security/secrets@2025-08-01-preview' = {
  name: 'radius-ghcr-registry-creds'
  properties: {
    environment: environment
    application: robotShopApp.id
    codeReference: '.radius/app.bicep#L547'
    data: {
      password: {
        value: registryPassword
      }
      username: {
        value: registryUsername
      }
    }
  }
}
