
__license__   = 'GPL v3'
__copyright__ = '2014, Lukasz Janyst <ljanyst@buggybrain.net>'

from calibre.ebooks.conversion.plugins.recipe_input import RecipeInput
from calibre.customize.conversion import OptionRecommendation

class JournalInput(RecipeInput):
  name        = 'JournalInput'
  author      = 'Lukasz Janyst <ljanyst@buggybrain.net>'
  description = _('Extend the RecipeInput to pass custom params to a recipe')
  file_types = set([])
  def __init__(self, *args):
    RecipeInput.__init__(self, *args)
    self.options.add(
      OptionRecommendation(
        name = 'journal_list_issues', recommended_value = None,
        help = _('List available issues') ) )
    self.options.add(
      OptionRecommendation(
        name = 'journal_download_issue', recommended_value = 0,
        help = _('Download selected issue') ) )

    self.options.add(
      OptionRecommendation(
        name = 'journal_cover', recommended_value = None,
        help = _('Path to the cover image') ) )
