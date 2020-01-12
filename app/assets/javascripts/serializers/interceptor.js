app.factory('serializerInterceptor', ['$q', function ($q) {
  return {
    response: function (response) {
      // Если в ответе найден сериалайзер, то
      if (response.data.serializer) {
        // Находим его в нашей глобальной области видимости
        var serializer = window[response.data.serializer];
        
        // Если он найден, то
        if (serializer) {
          // применяем его
          var collection = serializer(response.data.collection);
         
          // если результат ожидается как массив, то кладем его в поле collection, иначе в resource
          if (response.data.single) {
            response.data.resource = collection[0]
          } else {
            response.data.collection = collection;
          }
        } else {
          console.error(response.data.serializer + " is not defined")
        }
      }
      // Возвращаем измененный ответ с сервера
      return response || $q.when(response);
    }
  };
}])
// Кладем serializerInterceptor в стек перехватчиков для http-запросов, выполненных посредством Angular 
.config(['$httpProvider', function ($httpProvider) {
  $httpProvider.interceptors.push('serializerInterceptor');
}])
