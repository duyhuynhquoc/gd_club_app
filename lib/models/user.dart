import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gd_club_app/models/account.dart';
import 'package:gd_club_app/models/membership.dart';
import 'package:gd_club_app/models/organizer.dart';
import 'package:gd_club_app/models/role.dart';
import 'package:gd_club_app/models/team.dart';
import 'package:gd_club_app/providers/events.dart';
import 'package:gd_club_app/providers/memberships.dart';
import 'package:gd_club_app/providers/teams.dart';
import 'package:provider/provider.dart';

class User extends Account implements Organizer {
  User({
    required super.id,
    required super.email,
    required super.name,
    super.avatarUrl,
    required super.systemRole,
  });

  Future<void> createATeam(Team team, File? image, BuildContext context) async {
    team =
        await Provider.of<Teams>(context, listen: false).addTeam(team, image);

    final Role ownerRole =
        await Provider.of<Teams>(context, listen: false).addRoleToTeam(
      team.id,
      Role(
        id: null,
        title: 'Người sở hữu',
        isManager: true,
      ),
    );

    final Role memberRole =
        await Provider.of<Teams>(context, listen: false).addRoleToTeam(
      team.id,
      Role(
        id: null,
        title: 'Thành viên',
        isManager: false,
      ),
    );

    await Provider.of<Memberships>(context, listen: false).addMembership(
      Membership(memberId: id, teamId: team.id, role: ownerRole),
    );
  }

  Future<void> joinATeam(String teamId, BuildContext context) async {
    final List<Role> roleList =
        Provider.of<Teams>(context, listen: false).findTeamById(teamId)!.roles;

    final Role role =
        roleList[roleList.indexWhere((role) => role.title == 'Thành viên')];

    await Provider.of<Memberships>(context, listen: false).addMembership(
      Membership(memberId: id, teamId: teamId, role: role),
    );
  }

  Future<void> toggleRegisteredAnEvent(
      String eventId, BuildContext context) async {
    await Provider.of<Events>(context, listen: false)
        .toggleEventRegisteredStatus(eventId);
  }
}
