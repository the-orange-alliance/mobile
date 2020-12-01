import './models/award-recipient.dart';
import './models/event.dart';
import './models/event-participant.dart';
import './models/match.dart';
import './models/ranking.dart';
import './models/team.dart';
import './models/team-participant.dart';

class Sort {
  int eventParticipantSorter(EventParticipant a, EventParticipant b) {
    if (a.team.teamNumber < b.team.teamNumber) {
      return -1;
    } else if (a.team.teamNumber > b.team.teamNumber) {
      return 1;
    } else {
      return 0;
    }
  }

  int teamParticipantSorter(TeamParticipant a, TeamParticipant b) {
    return eventSorter(a.event, b.event) * -1;
  }

  int eventSorter(Event a, Event b) {
    return DateTime.parse(a.startDate).compareTo(DateTime.parse(b.startDate));
  }

  int teamSorter(Team a, Team b) {
    if (a.teamNumber < b.teamNumber) {
      return -1;
    } else if (a.teamNumber > b.teamNumber) {
      return 1;
    } else {
      return 0;
    }
  }

  int rankingSorter(Ranking a, Ranking b) {
    if (a.rank < b.rank) {
      return -1;
    } else if (a.rank > b.rank) {
      return 1;
    } else {
      return 0;
    }
  }

  int matchSorter(Match a, Match b) {
    int tournamentLevel1 = a.tournamentLevel;
    int tournamentLevel2 = b.tournamentLevel;
    int matchNumber1 = int.parse(a.matchKey.split("-")[3].substring(1, 4));
    int matchNumber2 = int.parse(b.matchKey.split("-")[3].substring(1, 4));
    int matchParticipant1 = int.parse(a.participants[0].teamKey);
    int matchParticipant2 = int.parse(b.participants[0].teamKey);
    bool isMatchRemote = a.participants.length == 1;

/**
 * if a match is remote but has already been sorted by team number, it will skip to the next condition: match number.
 */
    if (tournamentLevel1 == tournamentLevel2 && isMatchRemote && matchParticipant1 != matchParticipant2) {
      return matchParticipant1 < matchParticipant2 ? -1 : 1;
    } else if (tournamentLevel1 == tournamentLevel2) {
      return matchNumber1 < matchNumber2 ? -1 : 1;
    } else if (tournamentLevel1 == MatchType.FINALS_MATCH) {
      return 1;
    } else if (tournamentLevel2 == MatchType.FINALS_MATCH) {
      return -1;
    } else {
      return tournamentLevel1 < tournamentLevel2 ? -1 : 1;
    }
  }

  int awardParticipantSorter(AwardRecipient a, AwardRecipient b) {
    if (a.award != null && b.award != null) {
      if (a.award.displayOrder < b.award.displayOrder) {
        return -1;
      } else if (a.award.displayOrder > b.award.displayOrder) {
        return 1;
      }
    }
    return 0;
  }
}
