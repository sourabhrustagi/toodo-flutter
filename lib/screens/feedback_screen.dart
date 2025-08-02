import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final _commentController = TextEditingController();
  int _selectedRating = 0;
  String _selectedCategory = 'General';
  bool _isSubmitting = false;

  final List<String> _categories = [
    'General',
    'Feature Request',
    'Bug Report',
    'Improvement Suggestion',
  ];

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feedback'),
        actions: [
          IconButton(
            onPressed: () => _showFeedbackHistory(context),
            icon: const Icon(Icons.history),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Rating Section
            _buildSectionHeader(context, 'Rate Your Experience'),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      'How would you rate your experience?',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedRating = index + 1;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Icon(
                              index < _selectedRating ? Icons.star : Icons.star_border,
                              size: 40,
                              color: index < _selectedRating 
                                  ? Colors.amber 
                                  : theme.colorScheme.onSurface.withOpacity(0.3),
                            ),
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _getRatingText(_selectedRating),
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurface.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Category Selection
            _buildSectionHeader(context, 'Feedback Category'),
            Card(
              child: Column(
                children: _categories.map((category) {
                  return ListTile(
                    leading: Icon(_getCategoryIcon(category)),
                    title: Text(category),
                    trailing: Radio<String>(
                      value: category,
                      groupValue: _selectedCategory,
                      onChanged: (value) {
                        setState(() {
                          _selectedCategory = value!;
                        });
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Comment Section
            _buildSectionHeader(context, 'Additional Comments'),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tell us more about your experience',
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _commentController,
                      maxLines: 5,
                      maxLength: 500,
                      decoration: InputDecoration(
                        hintText: 'Share your thoughts, suggestions, or report issues...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: theme.colorScheme.surfaceVariant.withOpacity(0.3),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Your feedback helps us improve the app!',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurface.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Submit Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isSubmitting || _selectedRating == 0 
                    ? null 
                    : _submitFeedback,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: _isSubmitting
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text(
                        'Submit Feedback',
                        style: TextStyle(fontSize: 16),
                      ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Quick Actions
            _buildSectionHeader(context, 'Quick Actions'),
            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.bug_report),
                    title: const Text('Report a Bug'),
                    subtitle: const Text('Found an issue? Let us know'),
                    onTap: () => _quickAction('Bug Report'),
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.lightbulb),
                    title: const Text('Suggest Feature'),
                    subtitle: const Text('Have an idea? Share it'),
                    onTap: () => _quickAction('Feature Request'),
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.star),
                    title: const Text('Rate App'),
                    subtitle: const Text('Rate us on the app store'),
                    onTap: () {
                      // TODO: Open app store rating
                      _showSnackBar(context, 'Rating feature coming soon!');
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    final theme = Theme.of(context);
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
          color: theme.colorScheme.primary,
        ),
      ),
    );
  }

  String _getRatingText(int rating) {
    switch (rating) {
      case 0:
        return 'Tap to rate';
      case 1:
        return 'Poor';
      case 2:
        return 'Fair';
      case 3:
        return 'Good';
      case 4:
        return 'Very Good';
      case 5:
        return 'Excellent';
      default:
        return '';
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'General':
        return Icons.chat;
      case 'Feature Request':
        return Icons.lightbulb;
      case 'Bug Report':
        return Icons.bug_report;
      case 'Improvement Suggestion':
        return Icons.trending_up;
      default:
        return Icons.chat;
    }
  }

  void _quickAction(String category) {
    setState(() {
      _selectedCategory = category;
      _selectedRating = 5; // Default to 5 stars for quick actions
    });
    
    // Focus on comment field
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(FocusNode());
      Future.delayed(const Duration(milliseconds: 100), () {
        FocusScope.of(context).requestFocus(FocusNode());
      });
    });
  }

  Future<void> _submitFeedback() async {
    if (_selectedRating == 0) {
      _showSnackBar(context, 'Please select a rating');
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
      // TODO: Implement actual feedback submission
      _showSnackBar(context, 'Thank you for your feedback!');
      
      // Reset form
      setState(() {
        _selectedRating = 0;
        _selectedCategory = 'General';
        _commentController.clear();
      });
    } catch (e) {
      _showSnackBar(context, 'Failed to submit feedback. Please try again.');
    } finally {
      setState(() {
        _isSubmitting = false;
      });
    }
  }

  void _showFeedbackHistory(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Feedback History'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.star, color: Colors.amber),
              title: Text('App Experience'),
              subtitle: Text('5 stars - Excellent app!'),
              trailing: Text('2 days ago'),
            ),
            ListTile(
              leading: Icon(Icons.bug_report, color: Colors.red),
              title: Text('Bug Report'),
              subtitle: Text('Found an issue with task editing'),
              trailing: Text('1 week ago'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
      ),
    );
  }
} 