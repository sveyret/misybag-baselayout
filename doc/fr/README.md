# MisybaG baselayout

MisybaG baselayout contient les répertoires et fichiers de base pour le projet MisybaG.

# Langue

Le français étant ma langue maternelle, fournir les documents et messages en français n'est pas une option. Les autres traductions sont bienvenues.

Cependant, l'anglais étant la langue de la programmation, le code, y compris les noms de variable et commentaires, sont en anglais.

# Licence

Copyright © 2016 Stéphane Veyret stephane_POINT_veyret_CHEZ_neptura_POINT_org

MisybaG baselayout est un outil libre ; vous pouvez le redistribuer ou le modifier suivant les termes de la GNU General Public License telle que publiée par la Free Software Foundation ; soit la version 3 de la licence, soit (à votre gré) toute version ultérieure.

MisybaG baselayout est distribué dans l'espoir qu'il sera utile, mais SANS AUCUNE GARANTIE ; pas même la garantie implicite de COMMERCIALISABILITÉ ni d'ADÉQUATION à UN OBJECTIF PARTICULIER. Consultez la GNU General Public License pour plus de détails.

Vous devez avoir reçu une copie de la GNU General Public License en même temps que MisybaG baselayout ; si ce n'est pas le cas, consultez http://www.gnu.org/licenses.

Certains fichiers sont inspirés du sys-apps/baselayout de Gentoo et sont soit protégés par la GPLv2, soit dans le domaine public.

# Catégories de fichiers

Le système de fichier de base comporte 3 types de fichiers :
* Les fichiers indépendants de la machine qui, en principe, ne devraient pas être modifiés. Ces fichiers s'appuient, en général, sur d'autres fichiers qui contiennent la configuration propre à la machine. Ces fichiers peuvent potentiellement subir des mises à jours pour corrections ou améliorations.
* Les fichiers de base, nécessaires au fonctionnement du système, mais ayant une vie qui dépend de la machine. Ces fichiers contiennent des données qui dépendent du système, et ne devraient donc pas être mis à jour. Ces fichiers sont livrés avec l'extension « .template ». Cette extension peut être retirée lors de l'installation d'un nouveau système, tandis que les fichiers qui portent cette extension peuvent être ignorés lors d'une mise à jour.
* Les fichiers de pure configuration, non nécessaires au fonctionnement du système. Ces fichiers devraient être installé sur le système par un autre biais et ne doivent donc pas se trouver dans MisybaG baselayout.

# Démarrage des services

Gentoo propose deux modes d'initialisation : OpenRC et systemd. Si le _use flag_ systemd n'est pas positionné, les paquets considèrent qu'ils sont installés sur un système OpenRC. C'est ce choix que l'on fait avec MisybaG, mais comme, afin de garder le système extrêmement minimaliste, on ne va pas vraiment installer de système d'initialisation, on installe le script /sbin/openrc-run, dont le rôle est de permettre au scripts de lancement des services de démarrer comme si OpenRC était présent. Ce script ne remplit toutefois pas la totalité des rôles du vrai programme installé par OpenRC. En particulier, il ne gère pas de liens de dépendance, ni n'est capable de donner l'état d'un service.

Le fichier /lib/gentoo/service-functions est prévu pour être sourcé par les scripts impactés dans l'initialisation. Il fourni quelques aides pour ces scripts.

Le fichier /etc/init.d/rcS est le premier appelé lors du démarrage du système. C'est lui qui va lancer les services.

Tout comme avec OpenRC, le répertoire /etc/runlevel contient des liens vers les scripts OpenRC de démarrage des services, généralement contenus dans /etc/init.d. Ces liens sont généralement précédés d'un numéro d'ordre et se trouvent dans le sous-répertoire boot pour les services à démarrer au moment du démarrage de la machine. Un sous-répertoire after contenant lui-même des répertoires au nom de certains services, est également présent et permet de démarrer des services à la suite d'autres, contournant ainsi le problème de dépendance entre les services.

Les fichiers nécessaire sont fournis pour la gestion du réseau. Ils sont paramétrés pour se connecter à un réseau DHCP sur le port eth0. Ce fonctionnement est géré par le script /etc/init.d/network associé au fichier de configuration /etc/conf.d/network. Il utilise les services busybox ifplugd (pour détecter la connexion au réseau) et udhcpc (pour les baux DHCP).

# Connexion

Lors d'une connexion au système, le script /etc/profile est exécuté. Contrairement à un Gentoo classique, ce script va lire et sourcer directement l'ensemble des fichiers qui se trouvent dans /etc/env.d, exportant au passage toutes les variables définies (pas besoin d'exécuter env-update). En fin d'exécution, /etc/profile source l'ensemble des fichiers du répertoire /etc/profile.d se terminant par l'extension .sh, comme sur un environnement Gentoo classique.

Le fichier 50editor, qui défini vi comme éditeur par défaut est pré-installé dans env.d.
