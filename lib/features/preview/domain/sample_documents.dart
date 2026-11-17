/// Local sample documents used by the preview screen.
class SampleDocuments {
  const SampleDocuments._();

  static const Map<String, dynamic> welcome = {
    'id': 'root-container',
    'type': 'container',
    'properties': {'padding': 24},
    'children': [
      {
        'id': 'tag-text',
        'type': 'text',
        'properties': {
          'text': 'My First App',
          'fontSize': 14,
          'fontWeight': 600,
          'color': '#3978F6',
        },
      },
      {'id': 'spacer-1', 'type': 'spacer', 'properties': {'height': 8}},
      {
        'id': 'heading-text',
        'type': 'text',
        'properties': {'text': 'Welcome!', 'fontSize': 32, 'fontWeight': 700},
      },
      {'id': 'spacer-2', 'type': 'spacer', 'properties': {'height': 12}},
      {
        'id': 'desc-text',
        'type': 'text',
        'properties': {
          'text': 'Build something amazing with KLNP Studio.',
          'fontSize': 16,
          'fontWeight': 400,
        },
      },
      {'id': 'spacer-3', 'type': 'spacer', 'properties': {'height': 24}},
      {
        'id': 'cta-btn',
        'type': 'button',
        'properties': {'text': 'Get Started'},
      },
    ],
  };

  static const Map<String, dynamic> reloaded = {
    'id': 'sample-column',
    'type': 'column',
    'properties': {'crossAxisAlignment': 'start'},
    'children': [
      {
        'id': 'sample-text',
        'type': 'text',
        'properties': {
          'text': 'Reloaded Native UI',
          'fontSize': 24,
          'fontWeight': 700,
        },
      },
    ],
  };
}
