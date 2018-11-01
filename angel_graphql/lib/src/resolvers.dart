import 'package:angel_framework/angel_framework.dart';
import 'package:graphql_schema/graphql_schema.dart';

Map<String, dynamic> _fetchRequestInfo(Map<String, dynamic> arguments) {
  return <String, dynamic>{
    '__requestctx': arguments.remove('__requestctx'),
    '__responsectx': arguments.remove('__responsectx'),
  };
}

/// A GraphQL resolver that `index`es an Angel service.
///
/// The arguments passed to the resolver will be forwarded to the service, and the
/// service will receive [Providers.graphql].
GraphQLFieldResolver<Value, Serialized>
    resolveViaServiceIndex<Value, Serialized>(Service service) {
  return (_, arguments) async {
    var _requestInfo = _fetchRequestInfo(arguments);
    var params = {'query': arguments, 'provider': Providers.graphQL}
      ..addAll(_requestInfo);

    return await service.index(params) as Value;
  };
}

/// A GraphQL resolver that calls `findOne` on an Angel service.
///
/// The arguments passed to the resolver will be forwarded to the service, and the
/// service will receive [Providers.graphql].
GraphQLFieldResolver<Value, Serialized>
    resolveViaServiceFindOne<Value, Serialized>(Service service) {
  return (_, arguments) async {
    var _requestInfo = _fetchRequestInfo(arguments);
    var params = {'query': arguments, 'provider': Providers.graphQL}
      ..addAll(_requestInfo);
    return await service.findOne(params) as Value;
  };
}

/// A GraphQL resolver that `read`s a single value from an Angel service.
///
/// This resolver should be used on a field with at least the following inputs:
/// * `id`: a [graphQLId] or [graphQLString]
///
/// The arguments passed to the resolver will be forwarded to the service, and the
/// service will receive [Providers.graphql].
GraphQLFieldResolver<Value, Serialized>
    resolveViaServiceRead<Value, Serialized>(Service service,
        {String idField: 'id'}) {
  return (_, arguments) async {
    var _requestInfo = _fetchRequestInfo(arguments);
    var params = {'query': arguments, 'provider': Providers.graphQL}
      ..addAll(_requestInfo);
    var id = arguments.remove(idField);
    return await service.read(id, params) as Value;
  };
}

/// A GraphQL resolver that `modifies` a single value from an Angel service.
///
/// This resolver should be used on a field with at least the following inputs:
/// * `id`: a [graphQLId] or [graphQLString]
/// * `data`: a [GraphQLObjectType] corresponding to the format of `data` to be passed to `modify`
///
/// The arguments passed to the resolver will be forwarded to the service, and the
/// service will receive [Providers.graphql].
GraphQLFieldResolver<Value, Serialized>
    resolveViaServiceModify<Value, Serialized>(Service service,
        {String idField: 'id'}) {
  return (_, arguments) async {
    var _requestInfo = _fetchRequestInfo(arguments);
    var params = {'query': arguments, 'provider': Providers.graphQL}
      ..addAll(_requestInfo);
    var id = arguments.remove(idField);
    return await service.modify(id, arguments['data'], params) as Value;
  };
}

/// A GraphQL resolver that `update`s a single value from an Angel service.
///
/// This resolver should be used on a field with at least the following inputs:
/// * `id`: a [graphQLId] or [graphQLString]
/// * `data`: a [GraphQLObjectType] corresponding to the format of `data` to be passed to `update`
///
/// The arguments passed to the resolver will be forwarded to the service, and the
/// service will receive [Providers.graphql].
///
/// Keep in mind that `update` **overwrites** existing contents.
/// To avoid this, use [resolveViaServiceModify] instead.
GraphQLFieldResolver<Value, Serialized>
    resolveViaServiceUpdate<Value, Serialized>(Service service,
        {String idField: 'id'}) {
  return (_, arguments) async {
    var _requestInfo = _fetchRequestInfo(arguments);
    var params = {'query': arguments, 'provider': Providers.graphQL}
      ..addAll(_requestInfo);
    var id = arguments.remove(idField);
    return await service.update(id, arguments['data'], params) as Value;
  };
}

/// A GraphQL resolver that `remove`s a single value from an Angel service.
///
/// This resolver should be used on a field with at least the following inputs:
/// * `id`: a [graphQLId] or [graphQLString]
///
/// The arguments passed to the resolver will be forwarded to the service, and the
/// service will receive [Providers.graphql].
GraphQLFieldResolver<Value, Serialized>
    resolveViaServiceRemove<Value, Serialized>(Service service,
        {String idField: 'id'}) {
  return (_, arguments) async {
    var _requestInfo = _fetchRequestInfo(arguments);
    var params = {'query': arguments, 'provider': Providers.graphQL}
      ..addAll(_requestInfo);
    var id = arguments.remove(idField);
    return await service.remove(id, params) as Value;
  };
}
