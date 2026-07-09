import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nimora_worker/domain/repositories/jobs/jobs_repository.dart';

import '../../../domain/model/request/job_listing/job_listing_request_model.dart';
import 'job_listing_event.dart';
import 'job_listing_state.dart';

class MyJobsListBloc extends Bloc<MyJobsListEvent, MyJobsListState> {
  final JobsRepository jobsRepository;

  MyJobsListBloc({required this.jobsRepository}) : super(MyJobsListInitial()) {
    on<FetchMyJobsListEvent>(_onFetchMyJobs);
    on<RefreshMyJobsListEvent>(_onRefreshMyJobs);
  }

  Future<void> _onFetchMyJobs(
      FetchMyJobsListEvent event,
      Emitter<MyJobsListState> emit,
      ) async {
    emit(MyJobsListLoading());
    await _loadJobs(status: event.status, page: event.page, limit: event.limit, emit: emit);
  }

  Future<void> _onRefreshMyJobs(
      RefreshMyJobsListEvent event,
      Emitter<MyJobsListState> emit,
      ) async {
    // Keep showing current data while refreshing; only swap on success/error.
    await _loadJobs(status: event.status, page: 1, limit: 10, emit: emit);
  }

  Future<void> _loadJobs({
    required String status,
    required int page,
    required int limit,
    required Emitter<MyJobsListState> emit,
  }) async {
    try {
      final response = await jobsRepository.clientJobsListRequest(
        clientJobsRequestModel: ClientJobsRequestModel(
          status: status,
          page: page,
          limit: limit,
        ),
      );
      emit(
        MyJobsListLoaded(
          status: status,
          jobs: response.data?.jobs ?? [],
          total: response.data?.total ?? response.data?.jobs.length ?? 0,
        ),
      );
    } catch (e) {
      emit(MyJobsListError(message: e.toString().replaceFirst('Exception: ', '')));
    }
  }
}