// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_preference.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetUserPreferenceCollection on Isar {
  IsarCollection<UserPreference> get userPreferences => this.collection();
}

const UserPreferenceSchema = CollectionSchema(
  name: r'UserPreference',
  id: 916664336621196308,
  properties: {
    r'buddyPersonality': PropertySchema(
      id: 0,
      name: r'buddyPersonality',
      type: IsarType.string,
    ),
    r'id': PropertySchema(
      id: 1,
      name: r'id',
      type: IsarType.string,
    ),
    r'isDarkMode': PropertySchema(
      id: 2,
      name: r'isDarkMode',
      type: IsarType.bool,
    ),
    r'lockScreenEnabled': PropertySchema(
      id: 3,
      name: r'lockScreenEnabled',
      type: IsarType.bool,
    ),
    r'onboardingCompleted': PropertySchema(
      id: 4,
      name: r'onboardingCompleted',
      type: IsarType.bool,
    ),
    r'onboardingCompletedAt': PropertySchema(
      id: 5,
      name: r'onboardingCompletedAt',
      type: IsarType.dateTime,
    ),
    r'primaryColor': PropertySchema(
      id: 6,
      name: r'primaryColor',
      type: IsarType.string,
    ),
    r'secondaryColor': PropertySchema(
      id: 7,
      name: r'secondaryColor',
      type: IsarType.string,
    ),
    r'themeName': PropertySchema(
      id: 8,
      name: r'themeName',
      type: IsarType.string,
    ),
    r'userName': PropertySchema(
      id: 9,
      name: r'userName',
      type: IsarType.string,
    )
  },
  estimateSize: _userPreferenceEstimateSize,
  serialize: _userPreferenceSerialize,
  deserialize: _userPreferenceDeserialize,
  deserializeProp: _userPreferenceDeserializeProp,
  idName: r'isarId',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _userPreferenceGetId,
  getLinks: _userPreferenceGetLinks,
  attach: _userPreferenceAttach,
  version: '3.1.0+1',
);

int _userPreferenceEstimateSize(
  UserPreference object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.buddyPersonality.length * 3;
  bytesCount += 3 + object.id.length * 3;
  bytesCount += 3 + object.primaryColor.length * 3;
  bytesCount += 3 + object.secondaryColor.length * 3;
  bytesCount += 3 + object.themeName.length * 3;
  bytesCount += 3 + object.userName.length * 3;
  return bytesCount;
}

void _userPreferenceSerialize(
  UserPreference object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.buddyPersonality);
  writer.writeString(offsets[1], object.id);
  writer.writeBool(offsets[2], object.isDarkMode);
  writer.writeBool(offsets[3], object.lockScreenEnabled);
  writer.writeBool(offsets[4], object.onboardingCompleted);
  writer.writeDateTime(offsets[5], object.onboardingCompletedAt);
  writer.writeString(offsets[6], object.primaryColor);
  writer.writeString(offsets[7], object.secondaryColor);
  writer.writeString(offsets[8], object.themeName);
  writer.writeString(offsets[9], object.userName);
}

UserPreference _userPreferenceDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = UserPreference(
    buddyPersonality: reader.readString(offsets[0]),
    id: reader.readString(offsets[1]),
    isDarkMode: reader.readBool(offsets[2]),
    lockScreenEnabled: reader.readBoolOrNull(offsets[3]) ?? false,
    onboardingCompleted: reader.readBool(offsets[4]),
    onboardingCompletedAt: reader.readDateTimeOrNull(offsets[5]),
    primaryColor: reader.readString(offsets[6]),
    secondaryColor: reader.readString(offsets[7]),
    themeName: reader.readStringOrNull(offsets[8]) ?? 'azureSerenity',
    userName: reader.readString(offsets[9]),
  );
  object.isarId = id;
  return object;
}

P _userPreferenceDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readBool(offset)) as P;
    case 3:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 4:
      return (reader.readBool(offset)) as P;
    case 5:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readStringOrNull(offset) ?? 'azureSerenity') as P;
    case 9:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _userPreferenceGetId(UserPreference object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _userPreferenceGetLinks(UserPreference object) {
  return [];
}

void _userPreferenceAttach(
    IsarCollection<dynamic> col, Id id, UserPreference object) {
  object.isarId = id;
}

extension UserPreferenceQueryWhereSort
    on QueryBuilder<UserPreference, UserPreference, QWhere> {
  QueryBuilder<UserPreference, UserPreference, QAfterWhere> anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension UserPreferenceQueryWhere
    on QueryBuilder<UserPreference, UserPreference, QWhereClause> {
  QueryBuilder<UserPreference, UserPreference, QAfterWhereClause> isarIdEqualTo(
      Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: isarId,
        upper: isarId,
      ));
    });
  }

  QueryBuilder<UserPreference, UserPreference, QAfterWhereClause>
      isarIdNotEqualTo(Id isarId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<UserPreference, UserPreference, QAfterWhereClause>
      isarIdGreaterThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<UserPreference, UserPreference, QAfterWhereClause>
      isarIdLessThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<UserPreference, UserPreference, QAfterWhereClause> isarIdBetween(
    Id lowerIsarId,
    Id upperIsarId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerIsarId,
        includeLower: includeLower,
        upper: upperIsarId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension UserPreferenceQueryFilter
    on QueryBuilder<UserPreference, UserPreference, QFilterCondition> {
  QueryBuilder<UserPreference, UserPreference, QAfterFilterCondition>
      buddyPersonalityEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'buddyPersonality',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreference, UserPreference, QAfterFilterCondition>
      buddyPersonalityGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'buddyPersonality',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreference, UserPreference, QAfterFilterCondition>
      buddyPersonalityLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'buddyPersonality',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreference, UserPreference, QAfterFilterCondition>
      buddyPersonalityBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'buddyPersonality',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreference, UserPreference, QAfterFilterCondition>
      buddyPersonalityStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'buddyPersonality',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreference, UserPreference, QAfterFilterCondition>
      buddyPersonalityEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'buddyPersonality',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreference, UserPreference, QAfterFilterCondition>
      buddyPersonalityContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'buddyPersonality',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreference, UserPreference, QAfterFilterCondition>
      buddyPersonalityMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'buddyPersonality',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreference, UserPreference, QAfterFilterCondition>
      buddyPersonalityIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'buddyPersonality',
        value: '',
      ));
    });
  }

  QueryBuilder<UserPreference, UserPreference, QAfterFilterCondition>
      buddyPersonalityIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'buddyPersonality',
        value: '',
      ));
    });
  }

  QueryBuilder<UserPreference, UserPreference, QAfterFilterCondition> idEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreference, UserPreference, QAfterFilterCondition>
      idGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreference, UserPreference, QAfterFilterCondition>
      idLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreference, UserPreference, QAfterFilterCondition> idBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreference, UserPreference, QAfterFilterCondition>
      idStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreference, UserPreference, QAfterFilterCondition>
      idEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreference, UserPreference, QAfterFilterCondition>
      idContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreference, UserPreference, QAfterFilterCondition> idMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'id',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreference, UserPreference, QAfterFilterCondition>
      idIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<UserPreference, UserPreference, QAfterFilterCondition>
      idIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<UserPreference, UserPreference, QAfterFilterCondition>
      isDarkModeEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isDarkMode',
        value: value,
      ));
    });
  }

  QueryBuilder<UserPreference, UserPreference, QAfterFilterCondition>
      isarIdEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<UserPreference, UserPreference, QAfterFilterCondition>
      isarIdGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<UserPreference, UserPreference, QAfterFilterCondition>
      isarIdLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<UserPreference, UserPreference, QAfterFilterCondition>
      isarIdBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'isarId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserPreference, UserPreference, QAfterFilterCondition>
      lockScreenEnabledEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lockScreenEnabled',
        value: value,
      ));
    });
  }

  QueryBuilder<UserPreference, UserPreference, QAfterFilterCondition>
      onboardingCompletedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'onboardingCompleted',
        value: value,
      ));
    });
  }

  QueryBuilder<UserPreference, UserPreference, QAfterFilterCondition>
      onboardingCompletedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'onboardingCompletedAt',
      ));
    });
  }

  QueryBuilder<UserPreference, UserPreference, QAfterFilterCondition>
      onboardingCompletedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'onboardingCompletedAt',
      ));
    });
  }

  QueryBuilder<UserPreference, UserPreference, QAfterFilterCondition>
      onboardingCompletedAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'onboardingCompletedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<UserPreference, UserPreference, QAfterFilterCondition>
      onboardingCompletedAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'onboardingCompletedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<UserPreference, UserPreference, QAfterFilterCondition>
      onboardingCompletedAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'onboardingCompletedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<UserPreference, UserPreference, QAfterFilterCondition>
      onboardingCompletedAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'onboardingCompletedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserPreference, UserPreference, QAfterFilterCondition>
      primaryColorEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'primaryColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreference, UserPreference, QAfterFilterCondition>
      primaryColorGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'primaryColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreference, UserPreference, QAfterFilterCondition>
      primaryColorLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'primaryColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreference, UserPreference, QAfterFilterCondition>
      primaryColorBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'primaryColor',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreference, UserPreference, QAfterFilterCondition>
      primaryColorStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'primaryColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreference, UserPreference, QAfterFilterCondition>
      primaryColorEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'primaryColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreference, UserPreference, QAfterFilterCondition>
      primaryColorContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'primaryColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreference, UserPreference, QAfterFilterCondition>
      primaryColorMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'primaryColor',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreference, UserPreference, QAfterFilterCondition>
      primaryColorIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'primaryColor',
        value: '',
      ));
    });
  }

  QueryBuilder<UserPreference, UserPreference, QAfterFilterCondition>
      primaryColorIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'primaryColor',
        value: '',
      ));
    });
  }

  QueryBuilder<UserPreference, UserPreference, QAfterFilterCondition>
      secondaryColorEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'secondaryColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreference, UserPreference, QAfterFilterCondition>
      secondaryColorGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'secondaryColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreference, UserPreference, QAfterFilterCondition>
      secondaryColorLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'secondaryColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreference, UserPreference, QAfterFilterCondition>
      secondaryColorBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'secondaryColor',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreference, UserPreference, QAfterFilterCondition>
      secondaryColorStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'secondaryColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreference, UserPreference, QAfterFilterCondition>
      secondaryColorEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'secondaryColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreference, UserPreference, QAfterFilterCondition>
      secondaryColorContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'secondaryColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreference, UserPreference, QAfterFilterCondition>
      secondaryColorMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'secondaryColor',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreference, UserPreference, QAfterFilterCondition>
      secondaryColorIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'secondaryColor',
        value: '',
      ));
    });
  }

  QueryBuilder<UserPreference, UserPreference, QAfterFilterCondition>
      secondaryColorIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'secondaryColor',
        value: '',
      ));
    });
  }

  QueryBuilder<UserPreference, UserPreference, QAfterFilterCondition>
      themeNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'themeName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreference, UserPreference, QAfterFilterCondition>
      themeNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'themeName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreference, UserPreference, QAfterFilterCondition>
      themeNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'themeName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreference, UserPreference, QAfterFilterCondition>
      themeNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'themeName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreference, UserPreference, QAfterFilterCondition>
      themeNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'themeName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreference, UserPreference, QAfterFilterCondition>
      themeNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'themeName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreference, UserPreference, QAfterFilterCondition>
      themeNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'themeName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreference, UserPreference, QAfterFilterCondition>
      themeNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'themeName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreference, UserPreference, QAfterFilterCondition>
      themeNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'themeName',
        value: '',
      ));
    });
  }

  QueryBuilder<UserPreference, UserPreference, QAfterFilterCondition>
      themeNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'themeName',
        value: '',
      ));
    });
  }

  QueryBuilder<UserPreference, UserPreference, QAfterFilterCondition>
      userNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreference, UserPreference, QAfterFilterCondition>
      userNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'userName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreference, UserPreference, QAfterFilterCondition>
      userNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'userName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreference, UserPreference, QAfterFilterCondition>
      userNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'userName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreference, UserPreference, QAfterFilterCondition>
      userNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'userName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreference, UserPreference, QAfterFilterCondition>
      userNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'userName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreference, UserPreference, QAfterFilterCondition>
      userNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'userName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreference, UserPreference, QAfterFilterCondition>
      userNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'userName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreference, UserPreference, QAfterFilterCondition>
      userNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userName',
        value: '',
      ));
    });
  }

  QueryBuilder<UserPreference, UserPreference, QAfterFilterCondition>
      userNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'userName',
        value: '',
      ));
    });
  }
}

extension UserPreferenceQueryObject
    on QueryBuilder<UserPreference, UserPreference, QFilterCondition> {}

extension UserPreferenceQueryLinks
    on QueryBuilder<UserPreference, UserPreference, QFilterCondition> {}

extension UserPreferenceQuerySortBy
    on QueryBuilder<UserPreference, UserPreference, QSortBy> {
  QueryBuilder<UserPreference, UserPreference, QAfterSortBy>
      sortByBuddyPersonality() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'buddyPersonality', Sort.asc);
    });
  }

  QueryBuilder<UserPreference, UserPreference, QAfterSortBy>
      sortByBuddyPersonalityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'buddyPersonality', Sort.desc);
    });
  }

  QueryBuilder<UserPreference, UserPreference, QAfterSortBy> sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<UserPreference, UserPreference, QAfterSortBy> sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<UserPreference, UserPreference, QAfterSortBy>
      sortByIsDarkMode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDarkMode', Sort.asc);
    });
  }

  QueryBuilder<UserPreference, UserPreference, QAfterSortBy>
      sortByIsDarkModeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDarkMode', Sort.desc);
    });
  }

  QueryBuilder<UserPreference, UserPreference, QAfterSortBy>
      sortByLockScreenEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lockScreenEnabled', Sort.asc);
    });
  }

  QueryBuilder<UserPreference, UserPreference, QAfterSortBy>
      sortByLockScreenEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lockScreenEnabled', Sort.desc);
    });
  }

  QueryBuilder<UserPreference, UserPreference, QAfterSortBy>
      sortByOnboardingCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'onboardingCompleted', Sort.asc);
    });
  }

  QueryBuilder<UserPreference, UserPreference, QAfterSortBy>
      sortByOnboardingCompletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'onboardingCompleted', Sort.desc);
    });
  }

  QueryBuilder<UserPreference, UserPreference, QAfterSortBy>
      sortByOnboardingCompletedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'onboardingCompletedAt', Sort.asc);
    });
  }

  QueryBuilder<UserPreference, UserPreference, QAfterSortBy>
      sortByOnboardingCompletedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'onboardingCompletedAt', Sort.desc);
    });
  }

  QueryBuilder<UserPreference, UserPreference, QAfterSortBy>
      sortByPrimaryColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'primaryColor', Sort.asc);
    });
  }

  QueryBuilder<UserPreference, UserPreference, QAfterSortBy>
      sortByPrimaryColorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'primaryColor', Sort.desc);
    });
  }

  QueryBuilder<UserPreference, UserPreference, QAfterSortBy>
      sortBySecondaryColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'secondaryColor', Sort.asc);
    });
  }

  QueryBuilder<UserPreference, UserPreference, QAfterSortBy>
      sortBySecondaryColorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'secondaryColor', Sort.desc);
    });
  }

  QueryBuilder<UserPreference, UserPreference, QAfterSortBy> sortByThemeName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'themeName', Sort.asc);
    });
  }

  QueryBuilder<UserPreference, UserPreference, QAfterSortBy>
      sortByThemeNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'themeName', Sort.desc);
    });
  }

  QueryBuilder<UserPreference, UserPreference, QAfterSortBy> sortByUserName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userName', Sort.asc);
    });
  }

  QueryBuilder<UserPreference, UserPreference, QAfterSortBy>
      sortByUserNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userName', Sort.desc);
    });
  }
}

extension UserPreferenceQuerySortThenBy
    on QueryBuilder<UserPreference, UserPreference, QSortThenBy> {
  QueryBuilder<UserPreference, UserPreference, QAfterSortBy>
      thenByBuddyPersonality() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'buddyPersonality', Sort.asc);
    });
  }

  QueryBuilder<UserPreference, UserPreference, QAfterSortBy>
      thenByBuddyPersonalityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'buddyPersonality', Sort.desc);
    });
  }

  QueryBuilder<UserPreference, UserPreference, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<UserPreference, UserPreference, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<UserPreference, UserPreference, QAfterSortBy>
      thenByIsDarkMode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDarkMode', Sort.asc);
    });
  }

  QueryBuilder<UserPreference, UserPreference, QAfterSortBy>
      thenByIsDarkModeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDarkMode', Sort.desc);
    });
  }

  QueryBuilder<UserPreference, UserPreference, QAfterSortBy> thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<UserPreference, UserPreference, QAfterSortBy>
      thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<UserPreference, UserPreference, QAfterSortBy>
      thenByLockScreenEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lockScreenEnabled', Sort.asc);
    });
  }

  QueryBuilder<UserPreference, UserPreference, QAfterSortBy>
      thenByLockScreenEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lockScreenEnabled', Sort.desc);
    });
  }

  QueryBuilder<UserPreference, UserPreference, QAfterSortBy>
      thenByOnboardingCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'onboardingCompleted', Sort.asc);
    });
  }

  QueryBuilder<UserPreference, UserPreference, QAfterSortBy>
      thenByOnboardingCompletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'onboardingCompleted', Sort.desc);
    });
  }

  QueryBuilder<UserPreference, UserPreference, QAfterSortBy>
      thenByOnboardingCompletedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'onboardingCompletedAt', Sort.asc);
    });
  }

  QueryBuilder<UserPreference, UserPreference, QAfterSortBy>
      thenByOnboardingCompletedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'onboardingCompletedAt', Sort.desc);
    });
  }

  QueryBuilder<UserPreference, UserPreference, QAfterSortBy>
      thenByPrimaryColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'primaryColor', Sort.asc);
    });
  }

  QueryBuilder<UserPreference, UserPreference, QAfterSortBy>
      thenByPrimaryColorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'primaryColor', Sort.desc);
    });
  }

  QueryBuilder<UserPreference, UserPreference, QAfterSortBy>
      thenBySecondaryColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'secondaryColor', Sort.asc);
    });
  }

  QueryBuilder<UserPreference, UserPreference, QAfterSortBy>
      thenBySecondaryColorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'secondaryColor', Sort.desc);
    });
  }

  QueryBuilder<UserPreference, UserPreference, QAfterSortBy> thenByThemeName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'themeName', Sort.asc);
    });
  }

  QueryBuilder<UserPreference, UserPreference, QAfterSortBy>
      thenByThemeNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'themeName', Sort.desc);
    });
  }

  QueryBuilder<UserPreference, UserPreference, QAfterSortBy> thenByUserName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userName', Sort.asc);
    });
  }

  QueryBuilder<UserPreference, UserPreference, QAfterSortBy>
      thenByUserNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userName', Sort.desc);
    });
  }
}

extension UserPreferenceQueryWhereDistinct
    on QueryBuilder<UserPreference, UserPreference, QDistinct> {
  QueryBuilder<UserPreference, UserPreference, QDistinct>
      distinctByBuddyPersonality({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'buddyPersonality',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserPreference, UserPreference, QDistinct> distinctById(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'id', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserPreference, UserPreference, QDistinct>
      distinctByIsDarkMode() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isDarkMode');
    });
  }

  QueryBuilder<UserPreference, UserPreference, QDistinct>
      distinctByLockScreenEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lockScreenEnabled');
    });
  }

  QueryBuilder<UserPreference, UserPreference, QDistinct>
      distinctByOnboardingCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'onboardingCompleted');
    });
  }

  QueryBuilder<UserPreference, UserPreference, QDistinct>
      distinctByOnboardingCompletedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'onboardingCompletedAt');
    });
  }

  QueryBuilder<UserPreference, UserPreference, QDistinct>
      distinctByPrimaryColor({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'primaryColor', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserPreference, UserPreference, QDistinct>
      distinctBySecondaryColor({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'secondaryColor',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserPreference, UserPreference, QDistinct> distinctByThemeName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'themeName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserPreference, UserPreference, QDistinct> distinctByUserName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'userName', caseSensitive: caseSensitive);
    });
  }
}

extension UserPreferenceQueryProperty
    on QueryBuilder<UserPreference, UserPreference, QQueryProperty> {
  QueryBuilder<UserPreference, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<UserPreference, String, QQueryOperations>
      buddyPersonalityProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'buddyPersonality');
    });
  }

  QueryBuilder<UserPreference, String, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<UserPreference, bool, QQueryOperations> isDarkModeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isDarkMode');
    });
  }

  QueryBuilder<UserPreference, bool, QQueryOperations>
      lockScreenEnabledProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lockScreenEnabled');
    });
  }

  QueryBuilder<UserPreference, bool, QQueryOperations>
      onboardingCompletedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'onboardingCompleted');
    });
  }

  QueryBuilder<UserPreference, DateTime?, QQueryOperations>
      onboardingCompletedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'onboardingCompletedAt');
    });
  }

  QueryBuilder<UserPreference, String, QQueryOperations>
      primaryColorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'primaryColor');
    });
  }

  QueryBuilder<UserPreference, String, QQueryOperations>
      secondaryColorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'secondaryColor');
    });
  }

  QueryBuilder<UserPreference, String, QQueryOperations> themeNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'themeName');
    });
  }

  QueryBuilder<UserPreference, String, QQueryOperations> userNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'userName');
    });
  }
}
