class PuppetModule {
  final String slug;
  final String name;
  final int downloads;
  final String ownerUsername;
  final String version;
  final String summary;
  final String license;
  final List<String> tags;
  final String updatedAt;

  const PuppetModule({
    required this.slug,
    required this.name,
    required this.downloads,
    required this.ownerUsername,
    required this.version,
    required this.summary,
    required this.license,
    required this.tags,
    required this.updatedAt,
  });
}
