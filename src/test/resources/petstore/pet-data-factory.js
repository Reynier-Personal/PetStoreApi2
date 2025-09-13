(function() {
  var mergeObjects = function() {
    var result = {};
    for (var i = 0; i < arguments.length; i++) {
      var obj = arguments[i];
      if (obj) {
        for (var key in obj) {
          if (obj.hasOwnProperty(key)) {
            result[key] = obj[key];
          }
        }
      }
    }
    return result;
  };

  var createPet = function(options) {
    var defaults = {
      id: java.lang.System.currentTimeMillis(),
      categoryId: 1,
      categoryName: 'Dogs',
      name: 'DefaultPet',
      photoUrl: 'https://example.com/default.jpg',
      tagId: 1,
      tagName: 'friendly',
      status: 'available'
    };
    
    var petData = mergeObjects(defaults, options || {});
    
    return {
      id: petData.id,
      category: {
        id: petData.categoryId,
        name: petData.categoryName
      },
      name: petData.name,
      photoUrls: [petData.photoUrl],
      tags: [{
        id: petData.tagId,
        name: petData.tagName
      }],
      status: petData.status
    };
  };

  var createDog = function(name, options) {
    var dogDefaults = {
      categoryId: 1,
      categoryName: 'Dogs',
      name: name || 'DefaultDog',
      photoUrl: 'https://example.com/' + (name || 'dog').toLowerCase() + '.jpg',
      tagId: 1,
      tagName: 'loyal'
    };
    return createPet(mergeObjects(dogDefaults, options || {}));
  };

  var createCat = function(name, options) {
    var catDefaults = {
      categoryId: 2,
      categoryName: 'Cats',
      name: name || generateRealisticPetName('Cats'),
      photoUrl: 'https://example.com/' + (name || 'cat').toLowerCase() + '.jpg',
      tagId: 2,
      tagName: 'independent'
    };
    return createPet(mergeObjects(catDefaults, options || {}));
  };

  var createInvalidPet = function() {
    return {
      id: "invalid-id",
      name: null,
      status: "invalid-status"
    };
  };

  var createPetWithCategory = function(categoryName) {
    var timestamp = java.lang.System.currentTimeMillis();
    return {
      id: timestamp,
      category: {
        id: 1,
        name: categoryName || "Dogs"
      },
      name: "Pet_" + timestamp,
      photoUrls: ["https://example.com/photo.jpg"],
      tags: [{
        id: 1,
        name: "test-tag"
      }],
      status: "available"
    };
  };

  var createMinimalPet = function() {
    var timestamp = java.lang.System.currentTimeMillis();
    return {
      id: timestamp,
      name: "MinimalPet_" + timestamp,
      photoUrls: ["https://example.com/photo.jpg"],
      status: "available"
    };
  };

  var createBird = function(name, options) {
    var birdDefaults = {
      categoryId: 3,
      categoryName: 'Birds',
      name: name || generateRealisticPetName('Birds'),
      photoUrl: 'https://example.com/' + (name || 'bird').toLowerCase() + '.jpg',
      tagId: 3,
      tagName: 'colorful'
    };
    return createPet(mergeObjects(birdDefaults, options || {}));
  };

  var createPetWithMultiplePhotos = function(options) {
    var timestamp = java.lang.System.currentTimeMillis();
    var petData = mergeObjects({
      id: timestamp,
      name: generateRealisticPetName('Dogs') + '_' + timestamp,
      status: 'available'
    }, options || {});
    
    return {
      id: petData.id,
      category: {
        id: petData.categoryId || 1,
        name: petData.categoryName || 'Dogs'
      },
      name: petData.name,
      photoUrls: [
        'https://example.com/photo1.jpg',
        'https://example.com/photo2.jpg', 
        'https://example.com/photo3.jpg'
      ],
      tags: [{
        id: petData.tagId || 1,
        name: petData.tagName || 'friendly'
      }],
      status: petData.status
    };
  };

  var createPetWithMultipleTags = function(options) {
    var timestamp = java.lang.System.currentTimeMillis();
    var petData = mergeObjects({
      id: timestamp,
      name: generateRealisticPetName('Dogs') + '_' + timestamp,
      status: 'available'
    }, options || {});
    
    return {
      id: petData.id,
      category: {
        id: petData.categoryId || 1,
        name: petData.categoryName || 'Dogs'
      },
      name: petData.name,
      photoUrls: [petData.photoUrl || 'https://example.com/photo.jpg'],
      tags: [
        {id: 1, name: 'friendly'},
        {id: 2, name: 'trained'},
        {id: 3, name: 'playful'}
      ],
      status: petData.status
    };
  };

  var createPetWithSpecialName = function(nameType, options) {
    var timestamp = java.lang.System.currentTimeMillis();
    var specialNames = {
      spaces: 'Pet with spaces ' + timestamp,
      dashes: 'Pet-with-dashes-' + timestamp,
      underscores: 'Pet_with_underscores_' + timestamp,
      numbers: 'Pet123WithNumbers' + timestamp,
      mixed: 'Pet-123_Special Name_' + timestamp
    };
    
    var petData = mergeObjects({
      id: timestamp,
      name: specialNames[nameType] || specialNames.mixed,
      status: 'available'
    }, options || {});
    
    return createPet(petData);
  };

  var getPetSchema = function() {
    return {
      id: '#number',
      category: {
        id: '#number',
        name: '#string'
      },
      name: '#string',
      photoUrls: '#[] #string',
      tags: '#[]',
      status: '#string'
    };
  };

  var getCategorySchema = function() {
    return {
      id: '#number',
      name: '#string'
    };
  };

  var getTagSchema = function() {
    return {
      id: '#number', 
      name: '#string'
    };
  };

  var getDetailedPetSchema = function() {
    return {
      id: '#number',
      category: {
        id: '#number',
        name: '#string'
      },
      name: '#string',
      photoUrls: '#[] #string',
      tags: '#[]',
      status: '#regex (available|pending|sold)'
    };
  };

  var generateRealisticPetName = function(category, includeNumbers) {
    var dogNames = ['Max', 'Bella', 'Charlie', 'Lucy', 'Cooper', 'Luna', 'Buddy', 'Daisy', 'Rocky', 'Molly'];
    var catNames = ['Whiskers', 'Mittens', 'Shadow', 'Luna', 'Simba', 'Nala', 'Felix', 'Chloe', 'Tiger', 'Smokey'];
    var birdNames = ['Tweety', 'Rio', 'Sunny', 'Kiwi', 'Mango', 'Sky', 'Phoenix', 'Echo', 'Pepper', 'Ruby'];
    var generalNames = ['Buddy', 'Max', 'Bella', 'Charlie', 'Luna', 'Cooper', 'Daisy', 'Rocky', 'Molly', 'Jack'];
    
    var names;
    switch(category) {
      case 'Dogs': names = dogNames; break;
      case 'Cats': names = catNames; break;
      case 'Birds': names = birdNames; break;
      default: names = generalNames; break;
    }
    
    var randomIndex = Math.floor(Math.random() * names.length);
    var baseName = names[randomIndex];
    
    if (includeNumbers === false) {
      return baseName;
    }
    
    var timestamp = java.lang.System.currentTimeMillis().toString().slice(-3);
    return baseName + '_' + timestamp;
  };

  var createPurePetName = function(category) {
    return generateRealisticPetName(category, false);
  };

  var createCatPure = function(name, options) {
    var catDefaults = {
      categoryId: 2,
      categoryName: 'Cats',
      name: name || generateRealisticPetName('Cats', false),
      photoUrl: 'https://example.com/' + (name || 'cat').toLowerCase() + '.jpg',
      tagId: 2,
      tagName: 'independent'
    };
    return createPet(mergeObjects(catDefaults, options || {}));
  };

  var createBirdPure = function(name, options) {
    var birdDefaults = {
      categoryId: 3,
      categoryName: 'Birds',
      name: name || generateRealisticPetName('Birds', false),
      photoUrl: 'https://example.com/' + (name || 'bird').toLowerCase() + '.jpg',
      tagId: 3,
      tagName: 'colorful'
    };
    return createPet(mergeObjects(birdDefaults, options || {}));
  };

  var getExpectedHeaders = function() {
    return {
      'Content-Type': 'application/json',
      'Content-Length': '#string'
    };
  };

  // Exponer todas las funciones
  return {
    createPet: createPet,
    createDog: createDog,
    createCat: createCat,
    createInvalidPet: createInvalidPet,
    createPetWithCategory: createPetWithCategory,
    createMinimalPet: createMinimalPet,
    createBird: createBird,
    createPetWithMultiplePhotos: createPetWithMultiplePhotos,
    createPetWithMultipleTags: createPetWithMultipleTags,
    createPetWithSpecialName: createPetWithSpecialName,
    getPetSchema: getPetSchema,
    getCategorySchema: getCategorySchema,
    getTagSchema: getTagSchema,
    getDetailedPetSchema: getDetailedPetSchema,
    generateRealisticPetName: generateRealisticPetName,
    createPurePetName: createPurePetName,
    createCatPure: createCatPure,
    createBirdPure: createBirdPure,
    getExpectedHeaders: getExpectedHeaders
  };
})()